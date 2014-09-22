--[[
    检测更新模块
--]]


require "Extension/class"
require "Extension/debug"
require "Extension/register"

require "Manager/FileManager"

require "config"
require "assets"


--[[
    属性
--]]
UpdateManager =
{
    --单例
    instance = nil,

    --更新回调
    assetsDelegate = nil,
    --更新实例
    assetsManager = nil,

    --loading场景
    loadingBar = nil,
}


--[[
    单例类
--]]
UpdateManager = class("UpdateManager");


--[[
    获取单例
--]]
function UpdateManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建UpdateManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function UpdateManager:init()
    self.instance = nil;

    self.assetsManager = nil;
    self.loadingBar = nil;

    self:initAssetsDelegate();

    return true;
end


--[[
    删除单例
--]]
function UpdateManager:destroyInstance()
    self.instance = nil;

    return true;
end


--[[
    初始化更新回调函数
--]]
function UpdateManager:initAssetsDelegate()
    self.assetsDelegate = AssetsManagerDelegate:new();

    self.assetsDelegate:registerUpdateHandler(register(self, self.onError), kOnError);
    self.assetsDelegate:registerUpdateHandler(register(self, self.onProgress), kOnProgress);
    self.assetsDelegate:registerUpdateHandler(register(self, self.onSuccess), kOnSuccess);

    return true;
end


--[[
    初始化loadingLayer
--]]
function UpdateManager:initLoadingBar()
    self.loadingBar = SceneManager:getInstance():addLayer(LAYERS.loadingLayer, 6);

    return true;
end


--[[
    获取更新实例
--]]
function UpdateManager:getAssetsManager()
    if (not self.assetsManager) then
        local storagePath = CCFileUtils:sharedFileUtils():getWritablePath() .. VERSION.storagePath;
        self.assetsManager = AssetsManager:new(ASSETS.packageUrl, ASSETS.versionFileUrl, storagePath);
        self.assetsManager:setConnectionTimeout(VERSION.timeOut);

        --这里需要转换类型
        --因为调用类型判断的时候不会自动根据类型转换，即使是子类也不可以
        self.assetsManager:setDelegate(self.assetsDelegate);
    end

    return self.assetsManager;
end


--[[
    删掉更新实例
--]]
function UpdateManager:destroyAssetsManager()
    self.assetsManager = nil;
end


--[[
    更新失败回调函数
--]]
function UpdateManager:onError(errorCode)
    if (errorCode == AssetsManager.kCreateFile) then
        CCMessageBox("Error caused by creating a file to store downloaded data!", "Update False:");
    elseif (errorCode == AssetsManager.kNetwork) then
        CCMessageBox("Error caused by network!", "Update False:");
    elseif (errorCode == AssetsManager.kNoNewVersion) then
        CCMessageBox("There is not a new version!", "Update False:");
    elseif (errorCode == AssetsManager.kUncompress) then
        CCMessageBox("Error caused in uncompressing stage!", "Update False:")
    end

    return false;
end


--[[
    更新进度回调函数
--]]
function UpdateManager:onProgress(percent)
    if (not self.loadingBar) then
        self:initLoadingBar();
    end

    return self.loadingBar:setPercent(percent);
end


--[[
    更新成功回调函数
--]]
function UpdateManager:onSuccess()
    self:destroyAssetsManager();

    CCMessageBox("Please restart the game!", "Update Success:");

    return SceneManager:getInstance():exit();
end


--[[
    检测原始版本信息是否记录，没有的话将会记录
--]]
function UpdateManager:checkProgramVersion()
    local version = CCUserDefault:sharedUserDefault():getStringForKey(VERSION.programVersionCode);

    --如果版本不符合的话，不仅仅要记录新的信息，还要移除版本文件夹
    if (version ~= VERSION.programVersion) then
        local path = CCFileUtils:sharedFileUtils():getWritablePath() .. VERSION.storagePath;
        FileManager:getInstance():createFolder(path);

        CCUserDefault:sharedUserDefault():setStringForKey(VERSION.programVersionCode, VERSION.programVersion);
        CCUserDefault:sharedUserDefault():setStringForKey(VERSION.currentVersionCode, VERSION.programVersion);

        return false;
    else
        return true;
    end
end


--[[
    检测是否有更新
--]]
function UpdateManager:checkUpdate()
    return self:getAssetsManager():checkUpdate();
end


--[[
    更新
--]]
function UpdateManager:update()
    --更新前先添加文件夹
    local storagePathUrl = CCFileUtils:sharedFileUtils():getWritablePath() .. VERSION.storagePath;
    FileManager:getInstance():createFolder(storagePathUrl);

    return self:getAssetsManager():update();
end