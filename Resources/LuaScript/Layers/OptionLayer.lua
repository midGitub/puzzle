--[[
    选项层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "Manager/ClickManager"

require "resources"


--[[
    属性
--]]
OptionLayer =
{
    --按下返回之后的回调函数
    returnBtnHandler = nil;
}


--[[
    继承TouchGroup
--]]
OptionLayer = class("OptionLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建OptionLayer实例
--]]
function OptionLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建OptionLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function OptionLayer:init()
    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initReturnBtn();
    self:initRestartBtn();
    self:initMenuBtn();
    self:initExitBtn();

    return true;
end


--[[
    载入资源文件
--]]
function OptionLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.optionLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化返回游戏按钮
--]]
function OptionLayer:initReturnBtn()
    local returnBtn = self:getWidgetByName(COCOS_UI.optionLayer.returnBtn);
    returnBtn = tolua.cast(returnBtn, "Button");

    returnBtn:setPressedActionEnabled(true);
    returnBtn:addTouchEventListener(register(self, self.returnBtnOnTouch));

    return true;
end


--[[
    初始化重新游戏按钮
--]]
function OptionLayer:initRestartBtn()
    local restartBtn = self:getWidgetByName(COCOS_UI.optionLayer.restartBtn);
    restartBtn = tolua.cast(restartBtn, "Button");

    restartBtn:setPressedActionEnabled(true);
    restartBtn:addTouchEventListener(register(self, self.restartBtnOnTouch));

    return true;
end


--[[
    初始化菜单按钮
--]]
function OptionLayer:initMenuBtn()
    local menuBtn = self:getWidgetByName(COCOS_UI.optionLayer.menuBtn);
    menuBtn = tolua.cast(menuBtn, "Button");

    menuBtn:setPressedActionEnabled(true);
    menuBtn:addTouchEventListener(register(self, self.menuBtnOnTouch));

    return true;
end


--[[
    初始化退出游戏按钮
--]]
function OptionLayer:initExitBtn()
    local exitBtn = self:getWidgetByName(COCOS_UI.optionLayer.exitBtn);
    exitBtn = tolua.cast(exitBtn, "Button");

    exitBtn:setPressedActionEnabled(true);
    exitBtn:addTouchEventListener(register(self, self.exitBtnOnTouch));

    return true;
end


--[[
    onEnter
--]]
function OptionLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function OptionLayer:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function OptionLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    注册确认按钮的回调函数
--]]
function OptionLayer:registerReturnBtnHandler(handler)
    if (type(handler) ~= "function") then
        error("OptionLayer:registerReturnBtnHandler，参数错误！");

        return false;
    end

    self.returnBtnHandler = handler;

    return true;
end


--[[
    返回游戏按钮点击事件
--]]
function OptionLayer:returnBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.optionLayer.returnBtn)) then
            if (self.returnBtnHandler) then
                self.returnBtnHandler();
            end

            return self:removeFromParentAndCleanup(true);
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    重新按钮点击事件
--]]
function OptionLayer:restartBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.optionLayer.restartBtn)) then
            SceneManager:getInstance():replaceScene(SCENES.playScene);

            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    菜单按钮按钮点击事件
--]]
function OptionLayer:menuBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.optionLayer.menuBtn)) then
            PlayManager:destroyInstance();

            SceneManager:getInstance():replaceScene(SCENES.selectModeScene);

            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    退出按钮点击事件
--]]
function OptionLayer:exitBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.optionLayer.exitBtn)) then
            SceneManager:getInstance():exit();

            return true
        else
            return false;
        end
    else
        return false;
    end
end