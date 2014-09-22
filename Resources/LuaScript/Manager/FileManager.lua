--[[
    对文件进行管理操作
--]]


require "Extension/class"
require "Extension/debug"
require "Extension/math"


--[[
    属性
--]]
FileManager =
{
    instance = nil,
}


--[[
    单例类
--]]
FileManager = class("FileManager");


--[[
    获取单例
--]]
function FileManager:getInstance()
    if (not self.instance) then
        local instance = self:new();

        if (instance and instance:init()) then
            self.instance = instance;
        else
            error("创建FileManager单例失败！");

            instance = nil;

            return false;
        end
    end

    return self.instance;
end


--[[
    初始化
--]]
function FileManager:init()
    self.instance = nil;

    return true;
end


--[[
    删除单例
--]]
function FileManager:destroyInstance()
    self.instance = nil;
end


--[[
    转换地址路径，因为不同平台的分隔符不一样
--]]
function FileManager:convertPath(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    if (CCApplication:sharedApplication():getTargetPlatform() == kTargetWindows) then
        return string.gsub(path, "/", "\\");
    else
        return string.gsub(path, "\\", "/");
    end
end


--[[
    检查文件是否存在
--]]
function FileManager:isFileExist(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    path = self:convertPath(path);

    local file, msg = io.open(path, "rb");
    if (file) then
        file:close();

        return true;
    else
        return false, msg;
    end
end


--[[
    给文件等重命名
--]]
function FileManager:reName(originPath, newName)
    if (type(originPath) ~= "string" or type(newName) ~= string) then
        error("参数错误！");

        return false;
    end

    originPath = self:convertPath(originPath);

    --获取父文件夹
    path = self:getFatherFolder(originPath);
    --以防新名字已有文件，先删除
    self:deleteFile(path .. "/" .. newName);

    --执行成功返回0，执行失败返回1
    if (os.execute("rename " .. pathA .. " " .. pathB) == 0) then
        return true;
    else
        return false;
    end
end


--[[
    删除文件
    调用os.remove
    删除成功返回true，删除失败返回nil和出错信息的string
--]]
function FileManager:deleteFile(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    path = self:convertPath(path);

    return os.remove(path);
end


--[[
    复制文件
--]]
function copyFile(pathA, pathB)
    if (type(pathA) ~= "string" or type(pathB) ~= "string") then
        error("参数错误！");

        return false;
    end

    pathA = self:convertPath(pathA);
    pathB = self:convertPath(pathB);

    --[[ 该方法太复杂，直接使用命令更为快捷
    local fileA, msgA = io.open(pathA, "r");
    if (not fileA) then
        error(msgA);

        return false;
    end

    local fileB, msgB = io.open(pathB, "w");
    if (not fileB) then
        fileA:close();
        error(msgB);

        return false;
    end

    fileB:write(fileA:read("*all"));

    fileA:close();
    fileB:close();

    return true;
    --]]

    --执行成功返回0，执行失败返回1
    if (os.execute("cp " .. pathA .. " " .. pathB) == 0) then
        return true;
    else
        return false;
    end
end


--[[
    新建文件夹
    调用os.execute
    调用成功返回true，失败返回false
    此命令本身可以递归的创建文件夹
--]]
function FileManager:createFolder(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    path = self:convertPath(path);

    --执行成功返回0，执行失败返回1
    if (os.execute("mkdir " .. path) == 0) then
        return true;
    else
        return false;
    end
end


--[[
    算出父文件夹
--]]
function FileManager:getFatherFolder(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    path = self:convertPath(path);
    local start, last = nil, nil;

    if (CCApplication:sharedApplication():getTargetPlatform() == kTargetWindows) then
        start, last = findLastOf(path, "\\");
    else
        start, last = findLastOf(path, "/");
    end

    if (start) then
        return string.sub(path, 1, last - 1);
    else
        return fasle;
    end
end


--[[
    删除文件夹
    调用os.execute
    调用成功返回true，失败返回false
--]]
function FileManager:deleteFolder(path)
    if (type(path) ~= "string") then
        error("参数错误！");

        return false;
    end

    path = self:convertPath(path);

    local command = nil;
    if (CCApplication:sharedApplication():getTargetPlatform() == kTargetWindows) then
        command = "rd /s /q ";
    else
        command = "rm -r ";
    end

    --执行成功返回0，执行失败返回1
    if (os.execute(command .. path) == 0) then
        return true;
    else
        return false;
    end
end


--[[
    复制文件夹
    这个貌似有点问题，别用太多
--]]
function FileManager:copyFolder(pathA, pathB)
    if (type(pathA) ~= "string" or type(pathB) ~= "string") then
        error("参数错误！");

        return false;
    end

    pathA = self:convertPath(pathA);
    pathB = self:convertPath(pathB);

    local command, commandEx = nil, nil;
    if (CCApplication:sharedApplication():getTargetPlatform() == kTargetWindows) then
        command = "robocopy ";
        commandEx = " /E";
    else
        command = "cp -r ";
        commandEx = "";
    end

    --成功返回1，无需复制返回0，路径错误返回16
    if (os.execute(command .. pathA .. " " .. pathB .. commandEx) == 1) then
        return true;
    else
        return false;
    end
end