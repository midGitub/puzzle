--[[
    关卡层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"

require "Manager/ClickManager"
require "Manager/LevelManager"
require "Manager/PlayManager"

require "UI/List"

require "Level/levels"

require "resources"


--[[
    继承TouchGroup
--]]
LevelLayer = class("LevelLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建LevelLayer实例
--]]
function LevelLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建LevelLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function LevelLayer:init()
    self:registerScriptHandler(register(self, self.onNodeEvent));

    self:loadJson();
    self:initTrueBtn();
    self:initFalseBtn();
    self:initLevelList();

    return true;
end


--[[
    载入资源文件
--]]
function LevelLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.levelLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化确认按钮
--]]
function LevelLayer:initTrueBtn()
    local trueBtn = self:getWidgetByName(COCOS_UI.levelLayer.trueBtn);
    trueBtn = tolua.cast(trueBtn, "Button");

    trueBtn:setPressedActionEnabled(true);
    trueBtn:addTouchEventListener(register(self, self.trueBtnOnTouch));

    return true;
end


--[[
    初始化返回按钮
--]]
function LevelLayer:initFalseBtn()
    local falseBtn = self:getWidgetByName(COCOS_UI.levelLayer.falseBtn);
    falseBtn = tolua.cast(falseBtn, "Button");

    falseBtn:setPressedActionEnabled(true);
    falseBtn:addTouchEventListener(register(self, self.falseBtnOnTouch));

    return true;
end


--[[
    onEnter
--]]
function LevelLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(IMAGES.Button.btn);

    return true;
end


--[[
    onCleanUp
--]]
function LevelLayer:onCleanUp()
    LevelManager:destroyInstance();
    
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function LevelLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    确认按钮点击事件
--]]
function LevelLayer:trueBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.levelLayer.trueBtn)) then
            local sortModeCheckBox = self:getWidgetByName(COCOS_UI.levelLayer.sortModeCheckBox);
            sortModeCheckBox = tolua.cast(sortModeCheckBox, "CheckBox");
            local putModeCheckBox = self:getWidgetByName(COCOS_UI.levelLayer.putModeCheckBox);
            putModeCheckBox = tolua.cast(putModeCheckBox, "CheckBox");

            local level = LevelManager:getInstance():getSelectedLevel();
            local pm = PlayManager:getInstance();

            pm:setName(level.name);
            pm:setSortMode(sortModeCheckBox:getSelectedState());
            pm:setPutMode(putModeCheckBox:getSelectedState());
            pm:setImage(level.image);

            SceneManager:getInstance():replaceScene(SCENES.playScene);

            return true;
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
function LevelLayer:falseBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.levelLayer.falseBtn)) then
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
    设置显示
--]]
function LevelLayer:setLevel(id)
    local timeValue = self:getWidgetByName(COCOS_UI.levelLayer.timeValue);
    timeValue = tolua.cast(timeValue, "LabelBMFont");
    local touchValue = self:getWidgetByName(COCOS_UI.levelLayer.touchValue);
    touchValue = tolua.cast(touchValue, "LabelBMFont");
    local moveValue = self:getWidgetByName(COCOS_UI.levelLayer.moveValue);
    moveValue = tolua.cast(moveValue, "LabelBMFont");

    local sortModeCheckBox = self:getWidgetByName(COCOS_UI.levelLayer.sortModeCheckBox);
    sortModeCheckBox = tolua.cast(sortModeCheckBox, "CheckBox");
    local putModeCheckBox = self:getWidgetByName(COCOS_UI.levelLayer.putModeCheckBox);
    putModeCheckBox = tolua.cast(putModeCheckBox, "CheckBox");

    local lvm = LevelManager:getInstance();
    lvm:setSelectedLevel(id);

    timeValue:setText(lvm:getTimeWithId(id));
    touchValue:setText(lvm:getTouchWithId(id));
    moveValue:setText(lvm:getMoveWithId(id));

    sortModeCheckBox:setSelectedState(lvm:getSortModeWithId(id));
    if (not lvm:getSortModeEnabledWithId(id)) then
        sortModeCheckBox:setTouchEnabled(false);
        sortModeCheckBox:setColor(ccc3(127, 127, 127));
    else
        sortModeCheckBox:setTouchEnabled(true);
        sortModeCheckBox:setColor(ccc3(255, 255, 255));
    end

    putModeCheckBox:setSelectedState(lvm:getPutModeWithId(id));
    if (not lvm:getSortModeEnabledWithId(id)) then
        putModeCheckBox:setTouchEnabled(false);
        putModeCheckBox:setColor(ccc3(127, 127, 127));
    else
        putModeCheckBox:setTouchEnabled(true);
        putModeCheckBox:setColor(ccc3(255, 255, 255));
    end

    return true;
end


--[[
    初始化关卡选择列表
--]]
function LevelLayer:initLevelList()
    local lvm = LevelManager:getInstance();
    lvm:setLevels(PRACTIESELEVEL);
    num = lvm:getLevelNums();

    local panel = self:getWidgetByName(COCOS_UI.levelLayer.levelPanel);
    local pSize = panel:getSize();

    local this = self;

    --继承List进行重写
    local LevelList = class("LevelList", List);

    function LevelList:addCell(id)
        local btn = Button:create();
        btn:loadTextures(IMAGES.Button.button,
                            IMAGES.Button.buttonHighlighted,
                            IMAGES.Button.buttonDark,
                            UI_TEX_TYPE_PLIST);
        btn:setScale9Enabled(true);
        btn:setSize(CCSizeMake(pSize.width - 10 * 2, 100));
        btn:setTouchEnabled(false);

        local size = btn:getSize();
        local label = Label:create();
        label:setText(lvm:getNameWithId(id));
        label:setFontSize(36);
        label:setPosition(ccp(size.width / 2, - size.height / 2));
        btn:addChild(label);

        return btn;
    end

    function LevelList:cellSize(id)
        return pSize.width - 10 * 2, 100;
    end

    function LevelList:cellClicked(id)
        local btn = nil;

        --先关闭其它的高亮
        for i = self.startId, self.endId, 1 do
            btn = self.maskContent:getChildByTag(i);
            btn = tolua.cast(btn, "Widget");
            btn:setFocused(false);
        end

        btn = self.maskContent:getChildByTag(id);
        btn = tolua.cast(btn, "Widget");
        btn:setFocused(true);

        this:setLevel(id);

        return true;
    end

    function LevelList:onNodeEvent(event)
        if event == "enter" then
            self:initMaskContent();
            self:cellClicked(1);
        elseif event == "cleanup" then
            return self:delete();
        end

        return false;
    end

    local levelList = LevelList:create();
    levelList:setBounce(0, 100);
    levelList:setLocateEnabled(false);
    levelList:setDistance(0, 1);
    levelList:setAmountOfCells(num);
    levelList:setViewSize(pSize.width - 10 * 2, pSize.height - 10 * 2);
    levelList:setPosition(10, pSize.height - 10);
    levelList:setDirection(DIRECTION.vertical);
    panel:addNode(levelList, 3);

    return true;
end