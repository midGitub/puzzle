--[[
    对文件进行管理操作
--]]


require "Extension/class"
require "Extension/debug"

if (CCApplication:sharedApplication():getTargetPlatform() == kTargetAndroid) then
require "Extension/luaj"
end

require "resources"
require "config"


--[[
    网络状态
--]]
NETTYPE =
{
    [- 1] = "Windows",
    [0] = "None",
    [1] = "Wifi",
    [2] = "Net",
    [3] = "Wap",
}


--[[
    属性
--]]
Phone =
{
    instance = nil,
}


--[[
    单例类
--]]
Phone = class("Phone");


--[[
    获取单例
--]]
function Phone:getInstance()
    if (not self.instance) then
        self.instance = self:new();

        if (not self.instance and not self:init()) then
            error("创建Phone单例失败！");

            self.instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function Phone:init()
    self.instance = nil;

    return true;
end


--[[
    删除单例
--]]
function Phone:destroyInstance()
    self.instance = nil;
end


--[[
    获取手机IMEI信息
--]]
function Phone:getIMEI()
    if (CCApplication:sharedApplication():getTargetPlatform() == kTargetAndroid) then
        local flag, msg = luaj.callStaticMethod(JAVA.Phone.className, 
                                                JAVA.Phone.getIMEI.func, 
                                                nil, JAVA.Phone.getIMEI.sig);

        if (flag) then
            return msg;
        else
            error(LUA_JAVA_BRIDGE.errorCode[msg]);

            return false;
        end
    end

    return false;
end


--[[
    获取手机网络状态
--]]
function Phone:getNetType()
    local platform = CCApplication:sharedApplication():getTargetPlatform();

    if (platform == kTargetWindows) then
        return - 1;
    elseif (platform == kTargetAndroid) then
        local flag, msg = luaj.callStaticMethod(JAVA.Phone.className, 
                                                JAVA.Phone.getNetType.func, 
                                                nil, JAVA.Phone.getNetType.sig);

        if (flag) then
            return msg;
        else
            error(LUA_JAVA_BRIDGE.errorCode[msg]);

            return false;
        end
    end

    return false;
end