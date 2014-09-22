--[[
    选择模式层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "Manager/ClickManager"

require "resources"


--[[
    继承TouchGroup
--]]
SelectModeLayer = class("SelectModeLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建SelectModeLayer实例
--]]
function SelectModeLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建SelectModeLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function SelectModeLayer:init()
    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initPractiseBtn();
    self:initChallengeBtn();
    self:initRaceBtn();
    self:initHistoryBtn();
    self:initReturnBtn();

    return true;
end


--[[
    载入资源文件
--]]
function SelectModeLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.selectModeLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化练习模式按钮
--]]
function SelectModeLayer:initPractiseBtn()
    local practiseBtn = self:getWidgetByName(COCOS_UI.selectModeLayer.practiseBtn);
    practiseBtn = tolua.cast(practiseBtn, "Button");

    practiseBtn:setPressedActionEnabled(true);
    practiseBtn:addTouchEventListener(register(self, self.practiseBtnOnTouch));

    return true;
end


--[[
    初始化挑战模式按钮
--]]
function SelectModeLayer:initChallengeBtn()
    local challengeBtn = self:getWidgetByName(COCOS_UI.selectModeLayer.challengeBtn);
    challengeBtn = tolua.cast(challengeBtn, "Button");

    challengeBtn:setTouchEnabled(false);
    challengeBtn:setBright(false);
    challengeBtn:setPressedActionEnabled(true);
    challengeBtn:addTouchEventListener(register(self, self.challengeBtnOnTouch));

    return true;
end


--[[
    初始化竞赛模式按钮
--]]
function SelectModeLayer:initRaceBtn()
    local raceBtn = self:getWidgetByName(COCOS_UI.selectModeLayer.raceBtn);
    raceBtn = tolua.cast(raceBtn, "Button");

    raceBtn:setTouchEnabled(false);
    raceBtn:setBright(false);
    raceBtn:setPressedActionEnabled(true);
    raceBtn:addTouchEventListener(register(self, self.raceBtnOnTouch));

    return true;
end


--[[
    初始化历史模式按钮
--]]
function SelectModeLayer:initHistoryBtn()
    local historyBtn = self:getWidgetByName(COCOS_UI.selectModeLayer.historyBtn);
    historyBtn = tolua.cast(historyBtn, "Button");

    historyBtn:setTouchEnabled(false);
    historyBtn:setBright(false);
    historyBtn:setPressedActionEnabled(true);
    historyBtn:addTouchEventListener(register(self, self.historyBtnOnTouch));

    return true;
end


--[[
    初始化返回按钮
--]]
function SelectModeLayer:initReturnBtn()
    local returnBtn = self:getWidgetByName(COCOS_UI.selectModeLayer.returnBtn);
    returnBtn = tolua.cast(returnBtn, "Button");

    returnBtn:setPressedActionEnabled(true);
    returnBtn:addTouchEventListener(register(self, self.returnBtnOnTouch));

    return true;
end


--[[
    onEnter
--]]
function SelectModeLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function SelectModeLayer:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function SelectModeLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    练习模式按钮点击事件
--]]
function SelectModeLayer:practiseBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.selectModeLayer.practiseBtn)) then
            SceneManager:getInstance():replaceScene(SCENES.levelScene);

            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    挑战模式按钮点击事件
--]]
function SelectModeLayer:challengeBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.selectModeLayer.challengeBtn)) then
            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    竞赛模式按钮点击事件
--]]
function SelectModeLayer:raceBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.selectModeLayer.raceBtn)) then
            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    历史按钮点击事件
--]]
function SelectModeLayer:historyBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.selectModeLayer.historyBtn)) then
            return true
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    返回按钮点击事件
--]]
function SelectModeLayer:returnBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.loginLayer.loginBtn)) then
            SceneManager:getInstance():replaceScene(SCENES.loginScene);

            return true;
        else
            return false;
        end
    else
        return false;
    end
end