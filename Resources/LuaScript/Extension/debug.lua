--[[
	此文件用于输出测试用等，名称暂定
--]]


require "Extension/FileIO"


--[[
    记录debug信息的文件
--]]
local LOG_FILE = 
{
    fileName = CCFileUtils:sharedFileUtils():getWritablePath() .. "log.txt";
}


--[[
    for CCLuaEngine traceback
--]]
function __G__TRACKBACK__(msg)
    log("----------------------------------------");
    log("LUA ERROR: " .. tostring(msg) .. "\n");
    log(debug.traceback());
    log("----------------------------------------");

    --这个是报错之后调用的，可以报错之后退出游戏，暂时不调用
    --CCDirector:sharedDirector():endToLua();

    return true;
end


--[[
    测试输出用，将传进来的信息输出
--]]
cclog = function(...)
    return print(string.format(...));
end


--[[
    将输出信息写进文件
--]]
function fileLog(...)
    return FileIO:getInstacne():writeToFile(LOG_FILE, ...);
end


--[[
    通过在这里定义使用哪一种输出信息
--]]
log = cclog;