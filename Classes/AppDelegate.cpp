#include "cocos2d.h"
#include "CCEGLView.h"
#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "Lua_extensions_CCB.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "Lua_web_socket.h"
#endif

using namespace CocosDenshion;
USING_NS_CC;

using namespace std;

//配置
#include "config.h"
using namespace app;

//LuaJavaBridge
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#include "Extension/CCLuaJavaBridge/CCLuaJavaBridge.h"
#endif

//裁剪模块
#include "ToLua/LuaClippingArea/LuaClippingArea.h"
//网络更新模块
#include "ToLua/LuaAssetsManager/LuaAssetsManager.h"


AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();
    pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

    //设定程序资源设定大小
    CCEGLView::sharedOpenGLView()->setDesignResolutionSize(DESIGN_WIDTH, DESIGN_HEIGHT, ZOOM_POLICY);

    // turn on display FPS
    pDirector->setDisplayStats(DISPLAY_STATUS);

    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / STATUS);

    // register lua engine
    CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
    CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);

    CCLuaStack *pStack = pEngine->getLuaStack();
    lua_State *tolua_s = pStack->getLuaState();
    tolua_extensions_ccb_open(tolua_s);
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
    pStack = pEngine->getLuaStack();
    tolua_s = pStack->getLuaState();
    tolua_web_socket_open(tolua_s);
#endif

    //加入CCLuaJavaBridge
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    CCLuaJavaBridge::luaopen_luaj(tolua_s);
#endif

    //裁剪模块
    tolua_LuaClippingArea_open(tolua_s);
    //网络更新模块
    tolua_LuaAssetsManager_open(tolua_s);
    
#if (CC_TARGET_PLATFORM == CC_PLATFORM_BLACKBERRY)
    CCFileUtils::sharedFileUtils()->addSearchPath("script");
#endif

    //把下载的路径设置为最优先路径
    string updateLua = CCFileUtils::sharedFileUtils()->getWritablePath() + UPDATE_TMP + LUA_FOLDER;
    string updateUI = CCFileUtils::sharedFileUtils()->getWritablePath() + UPDATE_TMP + UI_FOLDER;
    string updatePath = CCFileUtils::sharedFileUtils()->getWritablePath() + UPDATE_TMP;
    vector<string> searchPaths = CCFileUtils::sharedFileUtils()->getSearchPaths();
    searchPaths.insert(searchPaths.begin(), updateLua);
    searchPaths.insert(searchPaths.begin(), updateUI);
    searchPaths.insert(searchPaths.begin(), updatePath);
    CCFileUtils::sharedFileUtils()->setSearchPaths(searchPaths);

    //添加UI资源路径
    CCFileUtils::sharedFileUtils()->addSearchPath(UI_FOLDER.c_str());
    //添加lua资源路径，无法使用addSearchResolutionsOrder
    CCFileUtils::sharedFileUtils()->addSearchPath(LUA_FOLDER.c_str());
    

//方便直接运行而添加的路径
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
    CCFileUtils::sharedFileUtils()->addSearchPath(SEARCH_PATH.c_str());
    CCFileUtils::sharedFileUtils()->addSearchPath((SEARCH_PATH + UI_FOLDER).c_str());
    CCFileUtils::sharedFileUtils()->addSearchPath((SEARCH_PATH + LUA_FOLDER).c_str());
#endif //(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)

    std::string path = CCFileUtils::sharedFileUtils()->fullPathForFilename(LUA_START.c_str());
    pEngine->executeScriptFile(path.c_str());

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->stopAnimation();

    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
    SimpleAudioEngine::sharedEngine()->pauseAllEffects();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    CCDirector::sharedDirector()->startAnimation();

    SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
    SimpleAudioEngine::sharedEngine()->resumeAllEffects();
}
