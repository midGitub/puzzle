--[[
    读取获取关卡信息
--]]


require "Extension/class"
require "Extension/debug"

require "Level/levels"


--[[
    属性
--]]
LevelManager =
{
    --单例
    instance = nil,

    --关卡数组，下标从1开始
    levels = {},

    --选中的level
    selectedLevel = nil,
}


--[[
    单例类
--]]
LevelManager = class("LevelManager");


--[[
    获取单例
--]]
function LevelManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建LevelManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function LevelManager:init()
    self.instance = nil;

    self.levels = {};

    return true;
end


--[[
    删除单例
--]]
function LevelManager:destroyInstance()
    self.instance = nil;

    return true;
end


--[[
    设置levels，以后获取信息就直接从这里获取了啦
--]]
function LevelManager:setLevels(levels)
    if (type(levels) ~= "table") then
        error("参数错误！");

        return false;
    end

    self.levels = levels;

    return true;
end


--[[
    获取关卡数
--]]
function LevelManager:getLevelNums()
    if (type(self.levels) == "table") then
        return #self.levels;
    else
        return false;
    end
end


--[[
    获取具体关卡
--]]
function LevelManager:getLevelWithId(id)
    if (type(id) ~= "number") then
        error("参数错误！");

        return false;
    end

    if (not self.levels) then
        error("关卡列表为空！");

        return false;
    end

    return self.levels[id];
end


--[[
    获取关卡名字
--]]
function LevelManager:getNameWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.name;
    else
        return false;
    end
end


--[[
    获取关卡描述
--]]
function LevelManager:getMessageWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.message;
    else
        return false;
    end
end


--[[
    获取关卡时间
--]]
function LevelManager:getTimeWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        local value = CCUserDefault:sharedUserDefault():getStringForKey(level.name .. LEVEL_HISTORY.timeValue);
        if (value == "") then
            value = "999";
            CCUserDefault:sharedUserDefault():setStringForKey(level.name .. LEVEL_HISTORY.timeValue, value);
        end

        return value;
    else
        return false;
    end
end


--[[
    获取触摸次数
--]]
function LevelManager:getTouchWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        local value = CCUserDefault:sharedUserDefault():getStringForKey(level.name .. LEVEL_HISTORY.touchValue);
        if (value == "") then
            value = "999";
            CCUserDefault:sharedUserDefault():setStringForKey(level.name .. LEVEL_HISTORY.touchValue, value);
        end

        return value;
    else
        return false;
    end
end


--[[
    获取移动次数
--]]
function LevelManager:getMoveWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        local value = CCUserDefault:sharedUserDefault():getStringForKey(level.name .. LEVEL_HISTORY.moveValue);
        if (value == "") then
            value = "999";
            CCUserDefault:sharedUserDefault():setStringForKey(level.name .. LEVEL_HISTORY.moveValue, value);
        end

        return value;
    else
        return false;
    end
end


--[[
    获取排序是否开启
--]]
function LevelManager:getSortModeEnabledWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.boolSortMode;
    else
        return false;
    end
end


--[[
    获取排序模式
--]]
function LevelManager:getSortModeWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.sortMode;
    else
        return false;
    end
end


--[[
    获取放置模式是否开启
--]]
function LevelManager:getPutModeEnabledWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.boolPutMode;
    else
        return false;
    end
end


--[[
    获取放置模式
--]]
function LevelManager:getPutModeWithId(id)
    local level = self:getLevelWithId(id);

    if (level) then
        return level.putMode;
    else
        return false;
    end
end


--[[
    设置选中的level
--]]
function LevelManager:setSelectedLevel(id)
    if (type(id) ~= "number") then
        error("LevelManager:setSelectedLevel，参数错误！");

        return false;
    end

    self.selectedLevel = self:getLevelWithId(id);

    return true;
end


--[[
    返回选中的level
--]]
function LevelManager:getSelectedLevel()
    if (self.selectedLevel) then
        return self.selectedLevel;
    else
        return nil;
    end
end