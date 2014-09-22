--[[
    loading层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "resources"


--[[
    继承TouchGroup
--]]
LoadingLayer = class("LoadingLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建LoadingLayer实例
--]]
function LoadingLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建LoadingLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function LoadingLayer:init()

    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initLoadingBar();

    return true;
end


--[[
    载入资源文件
--]]
function LoadingLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.loadingLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化文本信息
--]]
function LoadingLayer:initLoadingBar()
    return self:setPercent(60);
end


--[[
    onEnter
--]]
function LoadingLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function LoadingLayer:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function LoadingLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    获取loadingBar
--]]
function LoadingLayer:getLoadingBar()
    local loadingBar = self:getWidgetByName(COCOS_UI.loadingLayer.loadingBar);

    return tolua.cast(loadingBar, "LoadingBar");
end


--[[
    设置数值
--]]
function LoadingLayer:setPercent(percent)
    local loadingBar = self:getLoadingBar();

    return loadingBar:setPercent(percent);
end