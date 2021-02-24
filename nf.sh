#!/bin/bash
function test_ipv4() {
    result=`curl -4sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "\033[31m错误 无法连接到Netflix官网\033[0m";
        return;
    fi
    
    result=`curl -4sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "\033[31m很遗憾 你的IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -4sL "https://www.netflix.com/title/70143836" 2>&1`;
    result2=`curl -4sL "https://www.netflix.com/title/80027042" 2>&1`;
    result3=`curl -4sL "https://www.netflix.com/title/70140425" 2>&1`;
    result4=`curl -4sL "https://www.netflix.com/title/70283261" 2>&1`;
    result5=`curl -4sL "https://www.netflix.com/title/70143860" 2>&1`;
    result6=`curl -4sL "https://www.netflix.com/title/70202589" 2>&1`;
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "\033[33m你的IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";
        return;
    fi
    
    region=`tr [:lower:] [:upper:] <<< $(curl -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;

    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi

    echo -e "\033[32m恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}\033[0m";
    echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";
    return;
}

function test_ipv6() {
    result=`curl -6sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "\033[31m错误 无法连接到Netflix官网\033[0m";
        return;
    fi
    
    result=`curl -6sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "\033[31m很遗憾 你的IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -6sL "https://www.netflix.com/title/70143836" 2>&1`;
    result2=`curl -6sL "https://www.netflix.com/title/80027042" 2>&1`;
    result3=`curl -6sL "https://www.netflix.com/title/70140425" 2>&1`;
    result4=`curl -6sL "https://www.netflix.com/title/70283261" 2>&1`;
    result5=`curl -6sL "https://www.netflix.com/title/70143860" 2>&1`;
    result6=`curl -6sL "https://www.netflix.com/title/70202589" 2>&1`;
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "\033[33m你的IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";
        return;
    fi
    
    region=`tr [:lower:] [:upper:] <<< $(curl -6is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` ;
    
    if [[ "$region" == *"INDEX"* ]];then
       region="US";
    fi
    
    echo -e "\033[32m恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}\033[0m";
    echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";
    return;
}
export LANG="en_US";
export LANGUAGE="en_US";
export LC_ALL="en_US";
clear;
echo -e " ** 本脚本来源于互联网，仅供测试使用";
echo -e "\033[31m购买合租奈飞 https://is.gd/DyeEc6\033[0m";

curl -V > /dev/null 2>&1;
if [ $? -ne 0 ];then
    echo -e "\033[31mPlease install curl\033[0m";
    exit;
fi

echo " ** 正在测试IPv4解锁情况";
check4=`ping 1.1.1.1 -c 1 2>&1`;
if [[ "$check4" != *"unreachable"* ]] && [[ "$check4" != *"Unreachable"* ]];then
    test_ipv4;
else
    echo -e "\033[34m当前主机不支持IPv4,跳过...\033[0m";
fi

echo " ** 正在测试IPv6解锁情况";
check6=`ping6 240c::6666 -c 1 2>&1`;
if [[ "$check6" != *"unreachable"* ]] && [[ "$check6" != *"Unreachable"* ]];then
    test_ipv6;
else
    echo -e "\033[34m当前主机不支持IPv6,跳过...\033[0m";
fi
