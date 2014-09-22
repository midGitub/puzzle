--[[
    程序进入口
--]]


require "Extension/debug"
require "Extension/AudioEngine"

require "Manager/SceneManager"
require "Manager/UpdateManager"

require "resources"


local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100);
    collectgarbage("setstepmul", 5000);

    --检测版本记录信息
    UpdateManager:getInstance():checkProgramVersion();

    --进入开始场景
    SceneManager:getInstance():runStartScene();

    --播放音乐
    AudioEngine.playMusic(MUSICS.yourSong, true);
end


xpcall(main, __G__TRACKBACK__)