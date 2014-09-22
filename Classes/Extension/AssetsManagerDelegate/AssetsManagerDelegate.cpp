#include "AssetsManagerDelegate.h"

USING_NS_CC;


AssetsManagerDelegate::AssetsManagerDelegate():m_errorHandler(0), 
    m_progressHandler(0),
    m_successHandler(0)
{

}


AssetsManagerDelegate::~AssetsManagerDelegate()
{
    unRegisterUpdateHandler(kOnError);
    unRegisterUpdateHandler(kOnProgress);
    unRegisterUpdateHandler(kOnSuccess);
}


void AssetsManagerDelegate::onError(cocos2d::extension::AssetsManager::ErrorCode errorCode)
{
    if (m_errorHandler)
    {
        CCLuaStack *luaStack = getLuaStack();
        luaStack->pushInt(errorCode);
        luaStack->executeFunctionByHandler(m_errorHandler, 1);
    }
}


void AssetsManagerDelegate::onProgress(int percent)
{
    if (m_progressHandler)
    {
        CCLuaStack *luaStack = getLuaStack();
        luaStack->pushInt(percent);
        luaStack->executeFunctionByHandler(m_progressHandler, 1);
    }
}


void AssetsManagerDelegate::onSuccess()
{
    if (m_successHandler)
    {
        CCLuaStack *luaStack = getLuaStack();

        luaStack->executeFunctionByHandler(m_successHandler, 0);
    }
}


void AssetsManagerDelegate::registerUpdateHandler(int handler, UpdateCode code)
{
    //以防已经注册了相同的函数，先取消注册
    unRegisterUpdateHandler(code);

    //这只是注册一种函数，可以根据需求进行不同函数的注册，当然这里的写法就会相应的复杂
    switch(code)
    {
    case kOnError:
        {
            m_errorHandler = handler;
            break;
        }
    case kOnProgress:
        {
            m_progressHandler = handler;
            break;
        }
    case kOnSuccess:
        {
            m_successHandler = handler;
            break;
        }
    default:
        {
            break;
        }
    }
}


void AssetsManagerDelegate::unRegisterUpdateHandler(UpdateCode code)
{
    //保存临时值 
    int handler = 0;

    switch(code)
    {
    case kOnError:
        {
            handler = m_errorHandler;
            break;
        }
    case kOnProgress:
        {
            handler = m_progressHandler;
            break;
        }
    case kOnSuccess:
        {
            handler = m_successHandler;
            break;
        }
    default:
        {
            break;
        }
    }

    //仅当有注册的情况下执行
    if (!handler)
    {
        switch(code)
        {
        case kOnError:
            {
                m_errorHandler = 0;
                break;
            }
        case kOnProgress:
            {
                m_progressHandler = 0;
                break;
            }
        case kOnSuccess:
            {
                m_successHandler = 0;
                break;
            }
        default:
            {
                break;
            }
        }

        CCScriptEngineManager::sharedManager()->getScriptEngine()->removeScriptHandler(handler);
    }
}


cocos2d::CCLuaStack * AssetsManagerDelegate::getLuaStack()
{
    CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
    return pEngine->getLuaStack();
}

