--[[
    负责管理layer之间的跳转
--]]


require "Extension/class"
require "Extension/debug"

require "Layers/LoginLayer"
require "Layers/MessageBox"
require "Layers/LoadingLayer"
require "Layers/SelectModeLayer"
require "Layers/LevelLayer"
require "Layers/PlayLayer"
require "Layers/OptionLayer"


--[[
    记录所有的场景
--]]
SCENES =
{
    loginScene = "loginScene",
    selectModeScene = "selectModeScene",
    levelScene = "levelScene",
    playScene = "playScene",
}


--[[
    记录某些场景会返回的上一级场景
--]]


--[[
    记录所有的层
--]]
LAYERS =
{
    loginLayer = "loginLayer",
    messageBox = "messageBox",
    loadingLayer = "loadingLayer",
    selectModeLayer = "selectModeLayer",
    levelLayer = "levelLayer",
    playLayer = "playLayer",
    optionLayer = "optionLayer",
}


--[[
    属性
--]]
SceneManager =
{
    --单例
    instance = nil,
    --记录的上一个场景
    lastScene = nil,
    --当前场景
    currentScene = nil,
}


--[[
    单例类
--]]
SceneManager = class("SceneManager");


--[[
    获取单例
--]]
function SceneManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建SceneManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function SceneManager:init()
    self.instance = nil;

    self.lastScene = nil;
    self.currentScene = nil;

    return true;
end


--[[
    删除单例
--]]
function SceneManager:destroyInstance()
    self.instance = nil;
    
    return true;
end


--[[
    获取上一个场景信息
--]]
function SceneManager:getLastScene()
    return self.lastScene;
end


--[[
    返回上一个场景
--]]
function SceneManager:returnToLastScene()
    self:replaceScene(self.lastScene);
end


--[[
    运行场景
--]]
function SceneManager:runStartScene()
    --记录场景信息
    self.currentScene = SCENES.errorinScene;

    local scene = CCScene:create();
    local layer = self:getLayer(LAYERS.loginLayer);
    scene:addChild(layer);
    CCDirector:sharedDirector():runWithScene(scene);

    return scene;
end


--[[
    跳转到场景
--]]
function SceneManager:replaceScene(sceneNum)
    --先释放资源
    CCDirector:sharedDirector():purgeCachedData();

    local scene = CCScene:create();

    if (sceneNum == SCENES.loginScene) then
        local layer = self:getLayer(LAYERS.loginLayer);
        scene:addChild(layer);
    elseif (sceneNum == SCENES.selectModeScene) then
        local layer = self:getLayer(LAYERS.selectModeLayer);
        scene:addChild(layer);
    elseif (sceneNum == SCENES.levelScene) then
        local layer = self:getLayer(LAYERS.levelLayer);
        scene:addChild(layer);
    elseif (sceneNum == SCENES.playScene) then
        local layer = self:getLayer(LAYERS.playLayer);
        scene:addChild(layer);
    else
        return false;
    end

    --记录场景信息
    self.lastScene = self.currentScene;
    self.currentScene = sceneNum;

    CCDirector:sharedDirector():replaceScene(scene);

    return scene;
end


--[[
    获取layer
--]]
function SceneManager:getLayer(layerNum)
    local layer = nil;

    if (layerNum == LAYERS.loginLayer) then
        layer = LoginLayer:create();
    elseif (layerNum == LAYERS.messageBox) then
        layer = MessageBox:create();
    elseif (layerNum == LAYERS.loadingLayer) then
        layer = LoadingLayer:create();
    elseif (layerNum == LAYERS.selectModeLayer) then
        layer = SelectModeLayer:create();
    elseif (layerNum == LAYERS.levelLayer) then
        layer = LevelLayer:create();
    elseif (layerNum == LAYERS.playLayer) then
        layer = PlayLayer:create();
    elseif (layerNum == LAYERS.optionLayer) then
        layer = OptionLayer:create();
    end

    return layer;
end


--[[
    添加层
--]]
function SceneManager:addLayer(layerNum, ...)
    local scene = CCDirector:sharedDirector():getRunningScene();
    local layer = self:getLayer(layerNum);

    if (layer) then
        scene:addChild(layer, ...);
    end

    return layer;
end


--[[
    退出游戏
--]]
function SceneManager:exit()
    GUIReader:purge();

    return CCDirector:sharedDirector():endToLua();
end