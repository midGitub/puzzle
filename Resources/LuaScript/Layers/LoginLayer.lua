--[[
    登陆场景
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "Manager/UpdateManager"
require "Manager/ClickManager"

require "Phone/Phone"

require "resources"


--[[
    继承TouchGroup
--]]
LoginLayer = class("LoginLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建LoginLayer实例
--]]
function LoginLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建LoginLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function LoginLayer:init()
    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initLoginBtn();
    self:initUpdateBtn();
    self:initExitBtn();
    self:initVersion();

    return true;
end


--[[
    载入资源文件
--]]
function LoginLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.loginLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化登陆按钮
--]]
function LoginLayer:initLoginBtn()
    local errorinBtn = self:getWidgetByName(COCOS_UI.loginLayer.loginBtn);
    errorinBtn = tolua.cast(errorinBtn, "Button");

    errorinBtn:setPressedActionEnabled(true);
    errorinBtn:addTouchEventListener(register(self, self.loginBtnOnTouch));

    return true;
end


--[[
    初始化更新按钮
--]]
function LoginLayer:initUpdateBtn()
    local updateBtn = self:getWidgetByName(COCOS_UI.loginLayer.updateBtn);
    updateBtn = tolua.cast(updateBtn, "Button");

    updateBtn:setPressedActionEnabled(true);
    updateBtn:addTouchEventListener(register(self, self.updateBtnOnTouch));

    return true;
end


--[[
    初始化退出按钮
--]]
function LoginLayer:initExitBtn()
    local exitBtn = self:getWidgetByName(COCOS_UI.loginLayer.exitBtn);
    exitBtn = tolua.cast(exitBtn, "Button");

    exitBtn:setPressedActionEnabled(true);
    exitBtn:addTouchEventListener(register(self, self.exitBtnOnTouch));

    return true;
end


--[[
    初始化版本信息
--]]
function LoginLayer:initVersion()
    local ver = CCUserDefault:sharedUserDefault():getStringForKey(VERSION.currentVersionCode);

    local version = self:getWidgetByName(COCOS_UI.loginLayer.version);
    version = tolua.cast(version, "Label");
    version:setText("当前版本是：" .. ver);

    return true;
end


--[[
    onEnter
--]]
function LoginLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function LoginLayer:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function LoginLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    登陆按钮点击事件
--]]
function LoginLayer:loginBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.loginLayer.loginBtn)) then
            SceneManager:getInstance():replaceScene(SCENES.selectModeScene);

            return true;
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    确认更新后的事件
--]]
function LoginLayer:updateHandler()
    UpdateManager:getInstance():update();

    return true;
end


--[[
    根据是否有新版本来弹出MessageBox
--]]
function LoginLayer:updateLayer()
    if (UpdateManager:getInstance():checkUpdate()) then
        local version = CCUserDefault:sharedUserDefault():getStringForKey(VERSION.currentVersionCode);
        local netType = Phone:getInstance():getNetType();
        
        local text = "当前在 " .. NETTYPE[netType] .. " 环境下，当前版本是：" .. version .. "\n是否更新到下个版本？";

        local layer = SceneManager:getInstance():addLayer(LAYERS.messageBox, 3);
        layer:setText(text);
        layer:registerTrueBtnHandler(register(self, self.updateHandler));

        return true;
    end

    return false;
end


--[[
    更新按钮点击事件
--]]
function LoginLayer:updateBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.loginLayer.updateBtn)) then
            return self:updateLayer();
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
function LoginLayer:exitBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.loginLayer.exitBtn)) then
            return SceneManager:getInstance():exit();
        else
            return false;
        end
    else
        return false;
    end
end