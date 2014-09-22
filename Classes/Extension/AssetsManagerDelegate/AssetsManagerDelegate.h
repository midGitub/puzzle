/**
 *	用于AssetsManager在Lua中的回调
*/


#ifndef _ASSETSMANAGER_CALLBACK_H_
#define _ASSETSMANAGER_CALLBACK_H_


#include "AssetsManager/AssetsManager.h"

#include "CCLuaEngine.h"


/**
*	注册回调函数对应的code
*/
enum UpdateCode
{
    kOnError,           //更新失败
    kOnProgress,        //更新进度
    kOnSuccess,         //更新成功
};


/**
 *	继承于AssetsManagerDelegateProtocol
*/
class AssetsManagerDelegate:public cocos2d::extension::AssetsManagerDelegateProtocol
{
public:
    /**
    *	默认构造函数
    */
    AssetsManagerDelegate();
    /**
    *	默认析构函数
    */
    virtual ~AssetsManagerDelegate();

    /** 
    *   更新失败时候的回调函数
    */
    virtual void onError(cocos2d::extension::AssetsManager::ErrorCode errorCode);
    /** 
    *   更新进度回调函数
    */
    virtual void onProgress(int percent);
    /** 
    *   更新成功时候的回调函数
    */
    virtual void onSuccess();

    /**
    *	注册及取消回调
    */
    virtual void registerUpdateHandler(int handler, UpdateCode code);
    virtual void unRegisterUpdateHandler(UpdateCode code);

protected:
    /**
    *	获取Lua栈
    */
    cocos2d::CCLuaStack *getLuaStack();

    //更新失败回调
    int m_errorHandler;
    //更新进度回调
    int m_progressHandler;
    //更新成功回调
    int m_successHandler;
};


#endif  //_ASSETSMANAGER_CALLBACK_H_