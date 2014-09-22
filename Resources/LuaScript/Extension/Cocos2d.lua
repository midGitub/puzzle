--[[
    如果需要使用CocoStudio的话，就需要require该文件
--]]


require "Extension/CocoStudio"


--[[
    检查使用的参数
--]]
local ConfigType = 
{
    NONE = 0,
    COCOSTUDIO = 1,
}


--[[
    当读取jason文件的时候，C++会调用Lua的该函数
    所以真正的读取json文件是在Lua完成(如果项目用的是非Lua的话，就不会调用，那就是先检查引擎再调用)
--]]
function __onParseConfig(configType,jasonStr)
    if configType == ConfigType.COCOSTUDIO then
        TriggerMng.getInstance():parse(jasonStr)
    end
end
