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
    //�Է��Ѿ�ע������ͬ�ĺ�������ȡ��ע��
    unRegisterUpdateHandler(code);

    //��ֻ��ע��һ�ֺ��������Ը���������в�ͬ������ע�ᣬ��Ȼ�����д���ͻ���Ӧ�ĸ���
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
    //������ʱֵ 
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

    //������ע��������ִ��
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

