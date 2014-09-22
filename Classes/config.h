/**
 *	定义游戏各种属性的配置文件
*/

#ifndef _CONFIG_H_
#define _CONFIG_H_


/**
 *	定义main文件的属性，这些属性仅在游戏在win32中运行才会有效
*/
namespace screen
{
    //游戏名称
    const std::string GAME_NAME = "puzzle";

    //在win32平台中运行的大小
    const float SCREEN_WIDTH = 960;
    const float SCREEN_HEIGHT = 640;
}


/**
 *	定义程序相关等
*/
namespace app
{
    //程序设定大小
    const float DESIGN_WIDTH = 960;
    const float DESIGN_HEIGHT = 640;
    //缩放模式
    const ResolutionPolicy ZOOM_POLICY = kResolutionShowAll;

    //是否显示帧率
    const bool DISPLAY_STATUS = true;
    //帧率
    const double STATUS = 60.0;

    //Lua文件位置
    const std::string LUA_FOLDER = "LuaScript/";
    //Lua的启动文件
    const std::string LUA_START = "entrance.lua";

    //资源资源路径
    const std::string UI_FOLDER = "UI/";

    //Lua下载文件夹
    const std::string UPDATE_TMP = "VersionTemp/";

    //Win32下的搜索路径
    const std::string SEARCH_PATH = "../../Resources/";
}


#endif  //_CONFIG_H_