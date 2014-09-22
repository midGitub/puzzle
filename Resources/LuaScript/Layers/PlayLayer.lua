--[[
    玩家层
--]]


require "Extension/class"
require "Extension/register"
require "Extension/debug"
require "Extension/schedule"
require "Extension/AudioEngine"

require "Manager/ClickManager"
require "Manager/PlayManager"

require "UI/List"
require "UI/ZoomView"

require "resources"


--[[
    属性
--]]
PlayLayer =
{
    zoomContent = nil,
}


--[[
    继承TouchGroup
--]]
PlayLayer = class("PlayLayer", register(TouchGroup, TouchGroup.create));


--[[
    创建PlayLayer实例
--]]
function PlayLayer:create()
    local instance = self:new();
    if(instance and instance:init()) then
        return instance;
    else
        error("创建PlayLayer实例失败！");

        instance = nil;
        return nil;
    end
end


--[[
    初始化
--]]
function PlayLayer:init()
    self:registerScriptHandler(register(self, self.onNodeEvent));

    PlayManager:getInstance():updateList();

    self:loadJson();
    self:initTimeValue();
    self:initOptionBtn();
    self:initSelectList();
    self:initPuzzleList();

    return true;
end


--[[
    载入资源文件
--]]
function PlayLayer:loadJson()
    local widget = GUIReader:shareReader():widgetFromJsonFile(COCOS_UI.playLayer.json);
    self:addWidget(widget);

    return true;
end


--[[
    初始化timeValue
--]]
function PlayLayer:initTimeValue()
    local time = self:getWidgetByName(COCOS_UI.playLayer.timeValue);
    schedule(time, register(self, self.updateTime), 1);
end


--[[
    初始化选项按钮
--]]
function PlayLayer:initOptionBtn()
    local optionBtn = self:getWidgetByName(COCOS_UI.playLayer.optionBtn);
    optionBtn = tolua.cast(optionBtn, "Button");

    optionBtn:setPressedActionEnabled(true);
    optionBtn:addTouchEventListener(register(self, self.optionBtnOnTouch));

    return true;
end


--[[
    初始化选择列表
--]]
function PlayLayer:initSelectList()
    local putPanel = self:getWidgetByName(COCOS_UI.playLayer.selectPanel);
    local size = putPanel:getSize();
    local pm = PlayManager:getInstance();
    local image = pm:getImage();
    local this = self;

    --继承List重写
    local SelectList = class("SelectList", List);

    function SelectList:addCell(id)
        local chip = pm:getChipById(id);

        CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(image.plist);
        local sprite = CCSprite:createWithSpriteFrameName(image.name .. "_" .. chip.name .. ".png");

        --看看是否需要转换颜色
        if (chip.boolPut) then
            sprite:setColor(ccc3(127, 127, 127));
        end

        return sprite;
    end

    function SelectList:cellSize(id)
        return image.width, image.height;
    end

    function SelectList:cellClicked(id)
        local cell = self.maskContent:getChildByTag(id);
        
        --转换颜色
        local flag = pm:changeChipById(id);
        if (flag) then
            cell:setColor(ccc3(127, 127, 127));

            local tag = pm:putChipById(id);
            local chip = this.zoomNode:getChildByTag(tag);
            cell = tolua.cast(cell, "CCSprite");
            sprite = CCSprite:createWithTexture(cell:getTexture(),
                                                cell:getTextureRect());
            sprite:setPosition(image.width / 2, image.height / 2);
            sprite:setAnchorPoint(ccp(0.5, 0.5));
            chip:addChild(sprite, 3);

            performWithDelay(this, register(this, this.checkFinish), 0);
        else
            cell:setColor(ccc3(255, 255, 255));

            local tag = pm:returnChipById(id);
            local chip = this.zoomNode:getChildByTag(tag);
            chip:removeAllChildrenWithCleanup(true);
        end

        AudioEngine.playEffect(EFFECTS.bom, false);

        return true;
    end

    local direction = nil;
    local lastX = nil;
    function SelectList:onTouch(event, x, y)
        --先将坐标转换为以遮罩层物体的坐标，也就是self
        local pos = self:convertToNodeSpace(ccp(x, y));
        --使用转换好的坐标
        x, y = pos.x, pos.y;

        if (event == "began") then
            if (self.maskLayer:boundingBox():containsPoint(ccp(x, y))) then
                this:touchPlus();
            else
                return false;
            end

            direction = nil;
            lastX = x;

            return self:onTouchBegan(x, y);
        elseif (event == "moved") then
            if (direction) then
                if (x - lastX > 0) then
                    if (direction < 0) then
                        direction = 1;
                        this:movePlus();
                    end
                elseif (x - lastX < 0) then
                    if (direction > 0) then
                        direction = - 1;
                        this:movePlus();
                    end
                end
            else
                direction = x - lastX;
            end

            lastX = x;

            return self:onTouchMoved(x, y);
        elseif (event == "ended" or event == "cancelled") then
            return self:onTouchEnded(x, y);
        end
    end

    local selectList = SelectList:create();
    selectList:setBounce(100, 0);
    selectList:setLocateEnabled(false);
    selectList:setDistance(1, 0);
    selectList:setAmountOfCells(image.widthNum * image.heightNum);
    selectList:setViewSize(size.width - 5 * 2, size.height - 5 * 2);
    selectList:setPosition(5, 5);
    selectList:setDirection(DIRECTION.horizontal);
    putPanel:addNode(selectList, 3);

    return true;
end


--[[
    初始化解谜图
--]]
function PlayLayer:initPuzzleList()
    local panel = self:getPuzzlePanel();
    local pSize = panel:getSize();

    local pm = PlayManager:getInstance();
    local image = pm:getImage();

    self.zoomNode = CCNode:create();
    self.zoomNode:setAnchorPoint(ccp(0.5, 0.5));
    local width, height = image.width * image.widthNum, image.height * image.heightNum;
    self.zoomNode:setContentSize(CCSizeMake(width, height));

    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(image.plist);
    local sprite = nil;
    local id = nil;
    for i = 1, image.widthNum, 1 do
        for j = 1, image.heightNum, 1 do
            id = (i - 1) * image.widthNum + j;
            sprite = CCSprite:createWithSpriteFrameName(image.name .. "_" .. string.format("%03i", id - 1) .. ".png");
            sprite:setPosition(ccp((j - 1) * image.width + image.width / 2, 
                                    height - (i - 1) * image.width - image.width / 2));
            sprite:setTag(id);
            sprite:setColor(ccc3(127, 127, 127));
            self.zoomNode:addChild(sprite, 3);
        end
    end

    local zoomView = ZoomView:create();
    zoomView:setMaskContent(self.zoomNode);
    zoomView:setPosition(ccp(pSize.width / 2, pSize.height / 2));
    zoomView:setClippingSize(CCSizeMake(pSize.width - 10 * 2, pSize.height - 10 * 2));
    panel:addNode(zoomView, 3);

    return true;
end


--[[
    onEnter
--]]
function PlayLayer:onEnter()
    CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames();
    CCTextureCache:sharedTextureCache():removeUnusedTextures();

    return true;
end


--[[
    onCleanUp
--]]
function PlayLayer:onCleanUp()
    GUIReader:purge();

    return true;
end


--[[
    CCNode回调函数
--]]
function PlayLayer:onNodeEvent(event)
    if (event == "enter") then
        return self:onEnter();
    elseif (event == "cleanup") then
        return self:onCleanUp();
    end

    return false;
end


--[[
    更新时间
--]]
function PlayLayer:updateTime()
    local time = self:getWidgetByName(COCOS_UI.playLayer.timeValue);
    time = tolua.cast(time, "LabelBMFont");

    local value = time:getStringValue();
    value = value + 1;
    time:setText(string.format("%03i", value));

    return true;
end


--[[
    停止更新时间
--]]
function PlayLayer:stopUpdateTime()
    local time = self:getWidgetByName(COCOS_UI.playLayer.timeValue);
    
    CCDirector:sharedDirector():getActionManager():pauseTarget(time);

    return true;
end


--[[
    增加点击次数
--]]
function PlayLayer:touchPlus()
    local touchValue = self:getWidgetByName(COCOS_UI.playLayer.touchValue);
    touchValue = tolua.cast(touchValue, "LabelBMFont");

    local text = touchValue:getStringValue();
    touchValue:setText(string.format("%03i", text + 1));

    return true;
end


--[[
    增加移动次数
--]]
function PlayLayer:movePlus()
    local moveValue = self:getWidgetByName(COCOS_UI.playLayer.moveValue);
    moveValue = tolua.cast(moveValue, "LabelBMFont");

    local text = moveValue:getStringValue();
    moveValue:setText(string.format("%03i", text + 1));

    return true;
end


--[[
    恢复更新时间
--]]
function PlayLayer:resumeUpdateTime()
    local time = self:getWidgetByName(COCOS_UI.playLayer.timeValue);
    
    CCDirector:sharedDirector():getActionManager():resumeTarget(time);

    return true;
end


--[[
    选项按钮点击
--]]
function PlayLayer:optionBtnOnTouch(sender, event)
    if (event == TOUCH_EVENT_ENDED) then
        if (ClickManager:getInstance():canClick(COCOS_UI.levelLayer.trueBtn)) then
            self:stopUpdateTime();

            local layer = SceneManager:addLayer(LAYERS.optionLayer, 3);
            layer:registerReturnBtnHandler(register(self, self.resumeUpdateTime));

            return true;
        else
            return false;
        end
    else
        return false;
    end
end


--[[
    获取解谜Panel
--]]
function PlayLayer:getPuzzlePanel()
    return self:getWidgetByName(COCOS_UI.playLayer.puzzlePanel);
end


--[[
    判断是否完成，延迟一帧
--]]
function PlayLayer:checkFinish(sender)
    if (PlayManager:getInstance():checkFinish()) then
        self:stopUpdateTime();
        self:saveGame();
        
        local text = "返回主菜单请按“是”，重新游戏请按“否”！"
        local layer = SceneManager:getInstance():addLayer(LAYERS.messageBox, 3);
        layer:setText(text);
        layer:registerTrueBtnHandler(register(self, self.returnToMenu));
        layer:registerFalseBtnHandler(register(self, self.restartGame));

        return true;
    end

    return false;
end


--[[
    返回主菜单
--]]
function PlayLayer:returnToMenu()
    SceneManager:getInstance():replaceScene(SCENES.selectModeScene);

    return true;
end


--[[
    重新游戏
--]]
function PlayLayer:restartGame()
    SceneManager:getInstance():replaceScene(SCENES.playScene);

    return true;
end


--[[
    保存游戏信息
--]]
function PlayLayer:saveGame()
    local time = self:getWidgetByName(COCOS_UI.playLayer.timeValue);
    time = tolua.cast(time, "LabelBMFont");
    local touch = self:getWidgetByName(COCOS_UI.playLayer.touchValue);
    touch = tolua.cast(touch, "LabelBMFont");
    local move = self:getWidgetByName(COCOS_UI.playLayer.moveValue);
    move = tolua.cast(move, "LabelBMFont");

    PlayManager:getInstance():saveGame(time:getStringValue(),
                                        touch:getStringValue(),
                                        move:getStringValue());

    return true;
end