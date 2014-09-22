--[[
    这里主要是用于CocoStudio的场景触发器
    虽说编写是使用编辑器来写的，可是还是需要使用代码来辅助，真心鸡肋
    写法可以参考CocoStudioSceneTest.lua
--]]


require "Extension/class"
require "Extension/json"


--[[
    这些是暂时触发器功能可以注册的触发事件
--]]
triggerEventDef = 
{
    TRIGGEREVENT_ENTERSCENE = 0,
    TRIGGEREVENT_LEAVESCENE = 1,
    TRIGGEREVENT_INITSCENE  = 2,
    TRIGGEREVENT_UPDATESCENE = 3,
    TRIGGEREVENT_TOUCHBEGAN  = 4,
    TRIGGEREVENT_TOUCHMOVED  = 5,
    TRIGGEREVENT_TOUCHENDED  = 6,
    TRIGGEREVENT_TOUCHCANCELLED = 7,
}



--[[
    发送消息
    如果有注册该消息的函数，则执行函数
--]]
function sendTriggerEvent(event)
    --获取事件列表
    local triggerObjArr = TriggerMng.getInstance():get(event)
    
    if nil == triggerObjArr then
        return
    end

    for i = 1, table.getn(triggerObjArr) do
        local triObj = triggerObjArr[i]
        if nil ~= triObj and triObj:detect() then
            --非空便执行事件函数
            triObj:done()
        end
    end
end


--[[
    注册事件
    className是执行的事件名
    createFunc是该事件对象的生成函数的地址，一般使用new或者create
    具体使用参考CocoStudioSceneTest的acts.lua

    这里进行了重载（虽然是卸载了TInfo.ctor函数里面）
    具体使用看TInfo.ctor
--]]
function registerTriggerClass(className, createFunc)
    TInfo.new(className,createFunc)
end



--[[
    事件信息类
    保存事件的类名以及new函数
--]]
TInfo = class("TInfo")
TInfo._className = ""
TInfo._fun = nil


--[[
    初始化函数，使用new的时候会自动调用
--]]
function TInfo:ctor(c,f)
     -- @param {String|ccs.TInfo}c
     -- @param {Function}f
    if nil ~= f then
        self._className = c
        self._fun       = f
    else
        self._className = c._className
        self._fun       = c._fun
    end

    ObjectFactory.getInstance():registerType(self)
end



--[[
    对象工厂
    用于生成事件对象
--]]
ObjectFactory = class("ObjectFactory")
ObjectFactory._typeMap = nil
ObjectFactory._instance = nil


--[[
    初始化
--]]
function ObjectFactory:ctor()
    self._typeMap = {}
end


--[[
    获取单例
--]]
function ObjectFactory.getInstance()
    if nil == ObjectFactory._instance then
        ObjectFactory._instance = ObjectFactory.new()
    end

    return ObjectFactory._instance
end


--[[
    删除单例
--]]
function ObjectFactory.destroyInstance()
    ObjectFactory._instance = nil
end


--[[
    根据类名（事件名）来生成对象
    如果无该名，返回nil
--]]
function ObjectFactory:createObject(classname)
    local obj = nil
    local t   = self._typeMap[classname]
    if nil ~= t then
        obj = t._fun()
    end

    return obj
end


--[[
    注册事件时候保存事件对象，用于后续生成对象
--]]
function ObjectFactory:registerType(t)
    self._typeMap[t._className] = t
end



--[[
    触发器对象
    用于保存事件相关信息
--]]
TriggerObj = class("TriggerObj")
TriggerObj._cons = {}
TriggerObj._acts = {}
TriggerObj._enable = false
TriggerObj._id   = 0
TriggerObj._vInt = {}



--[[
    扩展继承
--]]
function TriggerObj.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, TriggerObj)
    return target
end


--[[
    初始化
--]]
function TriggerObj:ctor()
    self:init()
end


--[[
    初始化
--]]
function TriggerObj:init()
    self._id = 0
    self._enable = true
    self._cons = {}
    self._acts = {}
    self._vInt = {}
end


--[[
    检测触发对象是否可以触发
--]]
function TriggerObj:detect()
    if (not self._enable) or (table.getn(self._cons) == 0) then
        return true
    end 

    local ret = true
    local obj = nil
    for i = 1 , table.getn(self._cons) do
        obj = self._cons[i]
        if nil ~= obj and nil ~= obj.detect then
            ret = ret and obj:detect()
        end
    end
    return ret
end


--[[
    执行动作
--]]
function TriggerObj:done()
    if (not self._enable) or (table.getn(self._acts) == 0) then
        return
    end

    local obj = nil
    for i = 1, table.getn(self._acts) do
        obj = self._acts[i]
        if nil ~= obj and obj.done then
            obj:done()
        end
    end
end


--[[
    移除对象保存的所有的状态和动作信息
--]]
function TriggerObj:removeAll()
    local obj = nil
    for i=1, table.getn(self._cons) do
        obj = self._cons[i]
        if nil ~= obj then
            obj:removeAll()
        end
    end
    self._cons = {}

    for i=1, table.getn(self._acts) do
        obj = self._acts[i]
        if nil ~= obj then
            obj:removeAll()
        end
    end
    self._acts = {}
end


--[[
    序列化
    从json文件读取，并且序列化信息
--]]
function TriggerObj:serialize(jsonValue)
    self._id = jsonValue["id"]
    local count = 0

    --condition
    local cons = jsonValue["conditions"]
    if nil ~= cons then
        count = table.getn(cons)
        for i = 1, count do
            local subDict = cons[i]
            local className = subDict["classname"]
            if nil ~= className then
                local obj = ObjectFactory.getInstance():createObject(className)
                assert(nil ~= obj, string.format("class named %s can not implement!",className))
                obj:serialize(subDict)
                obj:init()
                table.insert(self._cons, obj)
            end
        end
    end

    local actions =  jsonValue["actions"]
    if nil ~= actions then
        count = table.getn(actions)
        for i = 1,count do
            local  subAction = actions[i]
            local  className = subAction["classname"]
            if nil ~= className then
                local act = ObjectFactory.getInstance():createObject(className)
                assert(nil ~= act ,string.format("class named %s can not implement!",className))
                act:serialize(subAction)
                act:init()
                table.insert(self._acts,act)
            end
        end
    end

    local events = jsonValue["events"]
    if nil ~= events then
        count = table.getn(events)
        for i = 1, count do
            local subEveent = events[i]
            local eventID   = subEveent["id"]
            if eventID >= 0 then
                table.insert(self._vInt,eventID)
            end
        end
    end
end


--[[
    获取ID
--]]
function TriggerObj:getId()
    return self._id
end


--[[
    设置触发器是否可以使用
--]]
function TriggerObj:setEnable(enable)
    self._enable = enable
end


--[[
    获取事件
--]]
function TriggerObj:getEvents()
    return self._vInt
end



--[[
    触发器管理器
--]]
TriggerMng = class("TriggerMng")
TriggerMng._eventTriggers = nil
TriggerMng._triggerObjs = nil
TriggerMng._movementDispatches =  nil
TriggerMng._instance  = nil


--[[
    初始化
--]]
function TriggerMng:ctor()
    self._triggerObjs = {}
    self._movementDispatches = {}
    self._eventTriggers = {}
end


--[[
    获取单例
--]]
function TriggerMng.getInstance()
    if TriggerMng._instance == nil then
        TriggerMng._instance = TriggerMng.new()
    end

    return TriggerMng._instance
end


--[[
    删除单例
--]]
function TriggerMng.destroyInstance()
    if TriggerMng._instance ~= nil then
        TriggerMng._instance:removeAll()
        TriggerMng._instance = nil
    end
end


--[[
    触发器管理器版本
--]]
function TriggerMng:triggerMngVersion()
    return "1.0.0.0"
end


--[[
    解析json文件信息，创建触发器对象
--]]
function TriggerMng:parse(jsonStr)
    local parseTable = json.decode(jsonStr,1)
    if nil == parseTable then
        return
    end

    local count = table.getn(parseTable)
    for i = 1, count do
        local subDict = parseTable[i]
        local triggerObj = TriggerObj.new()
        triggerObj:serialize(subDict)
        local events = triggerObj:getEvents()
        for j = 1, table.getn(events) do
            local event = events[j]
            self:add(event, triggerObj)
        end

        self._triggerObjs[triggerObj:getId()] =  triggerObj
    end
end


--[[
    根据event获取触发器对象
--]]
function TriggerMng:get(event)
    return self._eventTriggers[event]
end


--[[
    根据id获取触发器对象
--]]
function TriggerMng:getTriggerObj(id)
    return self._triggerObjs[id]
end


--[[
    增加新的触发器事件对象
--]]
function TriggerMng:add(event,triggerObj)
    local eventTriggers = self._eventTriggers[event]
    if nil == eventTriggers then
        eventTriggers = {}
    end

    local exist = false
    for i = 1, table.getn(eventTriggers) do
        if eventTriggers[i] == triggers then
            exist = true
            break
        end
    end

    if not exist then
        table.insert(eventTriggers,triggerObj)
        self._eventTriggers[event] = eventTriggers
    end
end


--[[
    移除所有的触发器
--]]
function TriggerMng:removeAll( )
    for k in pairs(self._eventTriggers) do
        local triObjArr = self._eventTriggers[k]
        for j = 1, table.getn(triObjArr) do
            local  obj = triObjArr[j]
            obj:removeAll()
        end
    end
    self._eventTriggers = {}
end


--[[
    根据参数移除
--]]
function TriggerMng:remove(event, obj)

    if nil ~= obj then
        return self:removeObjByEvent(event, obj)
    end

    assert(event >= 0,"event must be larger than 0")
    if nil == self._eventTriggers then
        return false
    end

    local triObjects =  self._eventTriggers[event]
    if nil == triObjects then
        return false
    end

    for i = 1, table.getn(triObjects) do
        local triObject = triggers[i]
        if nil ~= triObject then
            triObject:removeAll()
        end
    end

    self._eventTriggers[event] = nil
    return true
end


--[[
    根据参数移除
--]]
function TriggerMng:removeObjByEvent(event, obj)
    assert(event >= 0,"event must be larger than 0")
    if nil == self._eventTriggers then
        return false
    end

    local triObjects = self._eventTriggers[event]
    if nil == triObjects then
        return false
    end

    for i = 1,table.getn(triObjects) do
        local triObject = triObjects[i]
        if  nil ~= triObject and triObject == obj then
            triObject:removeAll()
            table.remove(triObjects, i)
            return true
        end
    end
end


--[[
    根据参数移除
--]]
function TriggerMng:removeTriggerObj(id)
    local obj = self.getTriggerObj(id)
    
    if nil == obj then
        return false
    end

    local events = obj:getEvents()
    for i = 1, table.getn(events) do
        self:remove(events[i],obj)
    end

    return true
end


--[[
    检测触发器管理器列表是否为空
--]]
function TriggerMng:isEmpty()
    return (not (nil == self._eventTriggers)) or table.getn(self._eventTriggers) <= 0
end
