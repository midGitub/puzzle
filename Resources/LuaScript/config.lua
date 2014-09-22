--[[
    配置信息
--]]


--[[
    版本相关信息
--]]
VERSION =
{
    --游戏原始版本信息
    programVersion = "000",
    --记录原始版本号信息的code
    programVersionCode = "program-version-code",
    --记录更新到的版本信息code
    currentVersionCode = "current-version-code",

    --更新路径
    storagePath = "VersionTemp",

    timeOut = 6,
}


--[[
    Java平台相关
--]]
if (CCApplication:sharedApplication():getTargetPlatform() == kTargetAndroid) then
    LUA_JAVA_BRIDGE =
    {
        errorCode =
        {
            [- 1] = "不支持的参数类型或返回值类型",
            [- 2] = "无效的签名",
            [- 3] = "没有找到指定的方法",
            [- 4] = "Java 方法执行时抛出了异常",
            [- 5] = "Java 虚拟机出错",
            [- 6] = "Java 虚拟机出错",
        },
    }

    JAVA =
    {
        Phone =
        {
            className = "com.zph.puzzle.Phone.Phone",

            getIMEI = 
            {
                func = "getIMEI",
                sig = "()Ljava/lang/String;",
            },

            getNetType = 
            {
                func = "getNetType",
                sig = "()I",
            },
        },
    }
end