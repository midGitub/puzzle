/**
 *	����AssetsManager��Lua�еĻص�
*/


#ifndef _ASSETSMANAGER_CALLBACK_H_
#define _ASSETSMANAGER_CALLBACK_H_


#include "AssetsManager/AssetsManager.h"

#include "CCLuaEngine.h"


/**
*	ע��ص�������Ӧ��code
*/
enum UpdateCode
{
    kOnError,           //����ʧ��
    kOnProgress,        //���½���
    kOnSuccess,         //���³ɹ�
};


/**
 *	�̳���AssetsManagerDelegateProtocol
*/
class AssetsManagerDelegate:public cocos2d::extension::AssetsManagerDelegateProtocol
{
public:
    /**
    *	Ĭ�Ϲ��캯��
    */
    AssetsManagerDelegate();
    /**
    *	Ĭ����������
    */
    virtual ~AssetsManagerDelegate();

    /** 
    *   ����ʧ��ʱ��Ļص�����
    */
    virtual void onError(cocos2d::extension::AssetsManager::ErrorCode errorCode);
    /** 
    *   ���½��Ȼص�����
    */
    virtual void onProgress(int percent);
    /** 
    *   ���³ɹ�ʱ��Ļص�����
    */
    virtual void onSuccess();

    /**
    *	ע�ἰȡ���ص�
    */
    virtual void registerUpdateHandler(int handler, UpdateCode code);
    virtual void unRegisterUpdateHandler(UpdateCode code);

protected:
    /**
    *	��ȡLuaջ
    */
    cocos2d::CCLuaStack *getLuaStack();

    //����ʧ�ܻص�
    int m_errorHandler;
    //���½��Ȼص�
    int m_progressHandler;
    //���³ɹ��ص�
    int m_successHandler;
};


#endif  //_ASSETSMANAGER_CALLBACK_H_