/**
 *	������Ϸ�������Ե������ļ�
*/

#ifndef _CONFIG_H_
#define _CONFIG_H_


/**
 *	����main�ļ������ԣ���Щ���Խ�����Ϸ��win32�����вŻ���Ч
*/
namespace screen
{
    //��Ϸ����
    const std::string GAME_NAME = "puzzle";

    //��win32ƽ̨�����еĴ�С
    const float SCREEN_WIDTH = 960;
    const float SCREEN_HEIGHT = 640;
}


/**
 *	���������ص�
*/
namespace app
{
    //�����趨��С
    const float DESIGN_WIDTH = 960;
    const float DESIGN_HEIGHT = 640;
    //����ģʽ
    const ResolutionPolicy ZOOM_POLICY = kResolutionShowAll;

    //�Ƿ���ʾ֡��
    const bool DISPLAY_STATUS = true;
    //֡��
    const double STATUS = 60.0;

    //Lua�ļ�λ��
    const std::string LUA_FOLDER = "LuaScript/";
    //Lua�������ļ�
    const std::string LUA_START = "entrance.lua";

    //��Դ��Դ·��
    const std::string UI_FOLDER = "UI/";

    //Lua�����ļ���
    const std::string UPDATE_TMP = "VersionTemp/";

    //Win32�µ�����·��
    const std::string SEARCH_PATH = "../../Resources/";
}


#endif  //_CONFIG_H_