/** 用于获取手机信息
*/


package com.zph.puzzle.Phone;

import com.zph.puzzle.puzzle;

import android.content.Context;
import android.telephony.TelephonyManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;


/** 此类仅用于返回手机的信息
*/
class Phone
{
    /** 获取IMEI码
    */
    public static String getIMEI()
    {
        //获取主Activity
        Context context = puzzle.getContext();

        return ((TelephonyManager)context.getSystemService(Context.TELEPHONY_SERVICE)).getDeviceId();
    }

    /** 
    *   获取网络判断，返回整形
    *   0 无网络；1 Wifi；2 Net；3 Wap
    */
    public static int getNetType()
    {
        Context context = puzzle.getContext();

        int netType = 0;
        ConnectivityManager connMgr = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE); 

        if (connMgr == null)
        {
            return netType;
        }

        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();
        if (networkInfo == null)
        {
            return netType;
        }

        int nType = networkInfo.getType();
        if (nType == ConnectivityManager.TYPE_MOBILE)
        {
            if (networkInfo.getExtraInfo().toLowerCase().equals("cmnet"))
            {
                netType = 2;
            }
            else
            {
                netType = 3;
            }
        }
        else if (nType == ConnectivityManager.TYPE_WIFI)
        {
            netType = 1;
        }

        return netType;
    }
}