--[[
    提示层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "Manager/ClickManager"

require "resources"


--[[
    属性
--]]
MessageBox =
{
    --按下确定之后的回调函数
    trueBtnHandler = nil;
    --按下否之后的回调函数
    falseBtnHandler = nil;
}


--[[
    继承TouchGroup
--]]
MessageBox = class("MessageBox", register(TouchGroup, TouchGroup.create));


--[[
    创建MessageBox实例
--]]
function MessageBox:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建MessageBox实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function MessageBox:init()
    self.trueBtnHandler = nil;
    self.falseBtnHandler = nil;

    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initText();
    self:initTrueBtn();
    self:initFalseBtn();

    return true;
end


--[[
    载入资源文件
--]]
function MessageBox:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.messageBox.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化文本信息
--]]
function MessageBox:initText()
    return self:setText("");
end


--[[
    设置文本信息
--]]
function MessageBox:setText(message)
    local text = self:getWidgetByName(COCOS_UI.messageBox.text);
    text = tolua.cast(text, "Label");

    return text:setText(message);
end


--[[
    初始化确认按钮
--]]
function MessageBox:initTrueBtn()
    local trueBtn = self:getWidgetByName(COCOS_UI.messageBox.trueBtn);
    trueBtn = tolua.cast(trueBtn, "Button");

    trueBtn:setPressedActionEnabled(true);
    trueBtn:addTouchEventListener(register(self, self.trueBtnOnTouch));

    return true;
end


--[[
    初始化返回按钮
--]]
function MessageBox:initFalseBtn()
    local falseBtn = self:getWidgetByName(COCOS_UI.messageBox.falseBtn);
    falseBtn = tolua.cast(falseBtn, "Button");

    falseBtn:setPressedActionEnabled(true);
    falseBtn:addTouchEventListener(register(self, self.falseBtnOnTouch));

    return true;
end


--[[
    onEnter
--]]
function MessageBox:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function MessageBox:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function MessageBox:onNodeEvent(event)
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
function MessageBox:registerTrueBtnHandler(handler)
    if (type(handler) ~= "function") then
        error("参数错误！");

        return false;
    end

    self.trueBtnHandler = handler;

    return true;
end


--[[
    确认按钮点击事件
--]]
function MessageBox:trueBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.messageBox.trueBtn)) then
            self:removeFromParentAndCleanup(true);

            if (self.trueBtnHandler) then
                self.trueBtnHandler();
            end

            return true;
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    注册否按钮的回调函数
--]]
function MessageBox:registerFalseBtnHandler(handler)
    if (type(handler) ~= "function") then
        error("参数错误！");

        return false;
    end

    self.falseBtnHandler = handler;

    return true;
end


--[[
    返回按钮点击事件
--]]
function MessageBox:falseBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.messageBox.falseBtn)) then
            self:removeFromParentAndCleanup(true);

            if (self.falseBtnHandler) then
                self.falseBtnHandler();
            end

            return true;
        else
            return false;
        end
    else
        return false;
    end
end