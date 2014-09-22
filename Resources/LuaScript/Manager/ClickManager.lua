--[[
    用于管理按钮的点击
--]]


require "Extension/class"
require "Extension/debug"


--[[
    按钮限制再次点击的时间
--]]
BUTTON_DELAY =
{
    time = 0.6;
}


--[[
    属性
--]]
ClickManager =
{
    --单例
    instance = nil,
    --注册按钮句柄的存储，使用字段作为区分
    buttonTimes = {},
}


--[[
    类
--]]
ClickManager = class("ClickManager");


--[[
    获取单例
--]]
function ClickManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建ClickManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    删除单例
--]]
function ClickManager:destroyInstance()
    self.instance = nil;

    return true;
end


--[[
    初始化
--]]
function ClickManager:init()
    self.instance = nil;
    self.buttonTimes = {};

    return true;
end


--[[
    按钮按下判断是否可以点击
    参数应该是字符串
--]]
function ClickManager:canClick(btn, delay)
    --如果没将延迟时间传进来，则使用默认的时间
    delay = delay or BUTTON_DELAY.time;

    if (type(btn) ~= "string" or type(delay) ~= "number") then
        error("参数错误！");

        return false;
    end

    --获取程序运行时间
    local sec = os.clock();

    --并没有记录数据
    if (not self.buttonTimes[btn]) then
        self.buttonTimes[btn] = sec;

        return true;
    else
        if (sec - self.buttonTimes[btn] > delay) then
            self.buttonTimes[btn] = sec;

            return true;
        else
            error("点击按钮过于频繁！");

            return false;
        end
    end
end