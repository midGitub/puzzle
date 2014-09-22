--[[
    游戏控制
--]]


require "Extension/class"
require "Extension/debug"

require "Level/levels"


--[[
    属性
--]]
PlayManager =
{
    --单例
    instance = nil,

    --关卡名称
    name = nil,
    --排序方式
    sortMode = nil,
    --放置方式
    putMode = nil,
    --资源信息
    image = {},

    --选择列表
    selectList = {},
    --拼图列表
    puzzleList = {},
}


--[[
    单例类
--]]
PlayManager = class("PlayManager");


--[[
    获取单例
--]]
function PlayManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建PlayManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function PlayManager:init()
    self.instance = nil;
    self.name = nil;
    self.sortMode = nil;
    self.putMode = nil;
    self.image = {};
    self.selectList = {};
    self.puzzleList = {};

    return true;
end


--[[
    删除单例
--]]
function PlayManager:destroyInstance()
    self.instance = nil;

    return true;
end


--[[
    设置名称
--]]
function PlayManager:setName(name)
    if (type(name) ~= "string") then
        error("参数错误！");

        return false;
    end

    self.name = name;

    return true;
end


--[[
    设置排序模式
--]]
function PlayManager:setSortMode(mode)
    if (type(mode) ~= "boolean") then
        error("参数错误！");

        return false;
    end

    self.sortMode = mode;

    return true;
end


--[[
    设置放置模式
--]]
function PlayManager:setPutMode(mode)
    if (type(mode) ~= "boolean") then
        error("参数错误！");

        return false;
    end

    self.putMode = mode;

    return true;
end


--[[
    设置图片资源
--]]
function PlayManager:setImage(image)
    if (type(image) ~= "table") then
        error("参数错误！");

        return false;
    end

    self.image = image;

    return true;
end


--[[
    获取图片资源信息
--]]
function PlayManager:getImage()
    return self.image;
end


--[[
    保存关卡记录
--]]
function PlayManager:saveGame(time, touch, move)
    if (type(time) ~= "string" or type(touch) ~= "string" or type(move) ~= "string") then
        error("参数错误！");

        return false;
    end

    local user = CCUserDefault:sharedUserDefault();
    timeValue = user:getStringForKey(self.name .. LEVEL_HISTORY.timeValue);
    touchValue = user:getStringForKey(self.name .. LEVEL_HISTORY.touchValue);
    moveValue = user:getStringForKey(self.name .. LEVEL_HISTORY.moveValue);

    if (time < timeValue) then
        user:setStringForKey(self.name .. LEVEL_HISTORY.timeValue, time);
    end
    if (touch < touchValue) then
        user:setStringForKey(self.name .. LEVEL_HISTORY.touchValue, touch);
    end
    if (move < moveValue) then
        user:setStringForKey(self.name .. LEVEL_HISTORY.moveValue, move);
    end

    return true;
end


--[[
    更新列表
--]]
function PlayManager:updateList()
    if (not self.image) then
        error("未初始化！");

        return false;
    end

    for i = 1, self.image.widthNum * self.image.heightNum, 1 do
        --碎片是从0开始的
        self.selectList[i] = 
        {
            name = string.format("%03i", i - 1),
            boolPut = false,
        };

        self.puzzleList[i] =
        {
            position = i,
            name = "999999",
        }
    end

    --如果排序模式打开了，则打乱
    if (self.sortMode) then
        local newId = nil;
        local t = nil;
        math.randomseed(os.time());
        for i = 1, self.image.widthNum * self.image.heightNum, 1 do
            --交换
            newId = math.random(1, self.image.widthNum * self.image.heightNum);
            t = self.selectList[i];
            self.selectList[i] = self.selectList[newId];
            self.selectList[newId] = t;
        end
    end

    --如果放置模式打开了，则打乱
    if (self.putMode) then
        local newId = nil;
        local t = nil;
        for i = 1, self.image.widthNum * self.image.heightNum, 1 do
            --交换
            newId = math.random(1, self.image.widthNum * self.image.heightNum);
            t = self.puzzleList[i];
            self.puzzleList[i] = self.puzzleList[newId];
            self.puzzleList[newId] = t;
        end
    end

    return true;
end


--[[
    返回碎片
--]]
function PlayManager:getChipById(id)
    if (type(id) ~= "number") then
        error("参数错误！");

        return false;
    end

    local chip = self.selectList[id];

    return chip;
end


--[[
    转换碎片放置判断
    返回新值
--]]
function PlayManager:changeChipById(id)
    if (type(id) ~= "number") then
        error("参数错误！");

        return false;
    end

    local chip = self.selectList[id]
    chip.boolPut = not chip.boolPut;

    return chip.boolPut;
end


--[[
    放置碎片
--]]
function PlayManager:putChipById(id)
    if (type(id) ~= "number") then
        error("参数错误！");

        return false;
    end

    local pos = nil;
    --获取放上去的位置
    for i = 1, self.image.widthNum * self.image.heightNum, 1 do
        if (self.puzzleList[i].name == "999999") then
            self.puzzleList[i].name = self.selectList[id].name;
            pos = self.puzzleList[i].position
            break;
        end
    end

    if (not pos) then
        error("数据有错！");

        return false;
    end

    return pos;
end


--[[
    收回碎片
--]]
function PlayManager:returnChipById(id)
    if (type(id) ~= "number") then
        error("参数错误！");

        return false;
    end

    local pos = nil;
    --获取放上去的位置
    for i = 1, self.image.widthNum * self.image.heightNum, 1 do
        if (self.puzzleList[i].name == self.selectList[id].name) then
            self.puzzleList[i].name = "999999";
            pos = self.puzzleList[i].position;
            break;
        end
    end

    if (not pos) then
        error("数据有错！");

        return false;
    end

    return pos;
end


--[[
    检测是否完成
--]]
function PlayManager:checkFinish()
    for i = 1, self.image.widthNum * self.image.heightNum, 1 do
        if (self.puzzleList[i].position ~= self.puzzleList[i].name + 1) then
            return false;
        end
    end

    return true;
end