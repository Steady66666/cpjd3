#!/bin/sh
#
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
white="\033[0m"
task_git(){
echo -e "拉取仓库"
if [ ! -f "/root/.ssh/Steady66666" ];then
	echo -e "文件不存在"
	cd /root/.ssh
	rm config
	wget https://raw.githubusercontent.com/Steady66666/cpjdprivatekey/main/.ssh/Steady66666
	wget https://raw.githubusercontent.com/Steady66666/cpjdprivatekey/main/.ssh/config
	chmod 600 -R /root/.ssh/Steady66666
	chmod 600 -R /root/.ssh/config
fi
if [ ! -d "/root/cpjd" ];then
	echo -e "$green 这是你第一次clone该仓库！！！ $white"
	cd /root
	git clone git@github.com:Steady66666/cpjd.git
	echo -e "完成"
fi
cd /root/cpjd
git fetch --all
git reset --hard origin/master
git pull
#git fetch判断是否是最新的
#git config --global credential.helper store //储存登陆信息
echo -e "***********************git登录信息已保存************************"
chmod 755 -R /root/cpjd
cp -rf /root/cpjd/shell/. /root
cd /root
}

task_ck(){
	\\echo -e "更新ck.sh"
	\\sleep 1
	\\cp -rf /root/cpjd/shell/ck.sh /root/ck.sh
	\\chmod 755 /root/ck.sh
	/usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_check_cookie.js

}

task_cp() {
echo -e "复制"
file_number=$(ls -l /usr/share/jd_openwrt_script/JD_Script/ccr_js|grep "^d"| wc -l)
while [[ ${file_number} -gt 0 ]];do
	cp -rf /root/cpjd/js/. /usr/share/jd_openwrt_script/JD_Script/ccr_js/js_$file_number
	file_number=$(($file_number - 1))
done
cp -rf /root/cpjd/js/. /usr/share/jd_openwrt_script/JD_Script/js
echo -e "复制完成"
}

#如果dir2目录已存在，则需要使用
#cp -r dir1/. dir2


timedtask_delete() {
echo -e "-------------------------删除定时任务-------------------------------"
	sed -i '/Ang/d' /etc/crontabs/root >/dev/null 2>&1
	sed -i '/#2580#/d' /etc/crontabs/root >/dev/null 2>&1
}

timedtask_add() {
echo -e "+++++++++++++++++++++++++添加定时任务+++++++++++++++++++++++++++++++"
cat >>/etc/crontabs/root <<EOF
#**********这里是Ang自制的助力脚本定时替换那啥#2580#**********#
40 9 * * *  /usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_dreamFactory.js #2580#
20 10 * * *  /usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_dreamFactory.js #2580#
59 10 * * *  /usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_dreamFactory.js #2580#
10 5,9,11,19,22,23 * * *  /root/cpjd.sh task_start >/tmp/cpjd.log 2>&1 #9,11,19,22点07分替换lxk0301脚本助力码#2580#
40 11,19,22 * * *  /usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_cash.js #2580#天天领现金
0 8 * * *  /usr/bin/node /usr/share/jd_openwrt_script/JD_Script/js/jd_bean_change.js #2580#账户变动
######2580##########请将其他定时任务放到底下########
EOF
/etc/init.d/cron restart
}


code_check() {
echo -e "*****************************检测一下助力码**********************************"
grep -ce "Ang" /usr/share/jd_openwrt_script/JD_Script/ccr_js/js_3/jdPlantBeanShareCodes.js
	if [ $? -ne 0 ] ; then 
		echo -e "!!!!!!!!!!!!!!!!!!!不对劲哟！请重新运行 sh /root/cpjd.sh"
		exit 0
	else 
		echo -e "##########################助力码检测成功##########################"
	fi
}

task_start(){
clear
echo -e "===============此脚本为Steady66666私有库所拥有不对外开放================================="
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
sleep 2s
clear
echo -e "*************************开始执行脚本***************************"
echo -e "         🀙🀚🀛🀜🀝🀞🀟🀠🀡🀢🀣"
echo -e "🀥          🀗🀐🀏🀎🀍🀌🀋🀊🀉         🀥"
echo -e "🀖         🀗                   🀙     🀥"
echo -e "🀘         🀗                   🀙     🀔"
echo -e "🀕         🀡                   🀁     🀁"
echo -e "🀖         🀗                   🀁     🀁"
echo -e "🀘           🀎🀍🀌🀋🀊🀉🀇🀉🀇        🀁"
echo -e "          🀐🀏🀎🀍🀌🀋🀊🀉🀇🀆🀅🀁 "
task_git
task_cp
code_check
sleep 2s
clear
echo -e "*************************START运行完成**************************"
}

time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "开始执行时间：${time}"
sleep 2s
task_start
sleep 2s
clear
timedtask_delete
sleep 1s
timedtask_add
task_ck
sleep 1s
clear
install_sftp(){

	opkg update
	opkg install vsftpd openssh-sftp-server

	/etc/init.d/vsftpd enable
	/etc/init.d/vsftpd start
	echo -e "安装完成！！！"
	sleep 1
}

check_sftp(){
echo -e "检测SFTP是否安装。。。"
opkg list-installed | grep "sftp"
	if [ $? -ne 0 ];then
		echo -e "SFTP不存在，开始安装!"
		sleep 1
		install_sftp	
	else
		echo -e "SFTP已经安装成功！不需要重复安装。。。"
		sleep 1
	fi
}
check_sftp
echo -e "****************************ALL脚本执行完成****************"
echo -e "Enjoy~~~"
