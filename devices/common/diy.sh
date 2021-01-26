#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions 
# Lisence: MIT
# 参考以下资料：
# Frome: https://github.com/garypang13/Actions-OpenWrt
# Frome: https://github.com/P3TERX/Actions-OpenWrt
# Frome: https://github.com/Lienol/openwrt-actions
# Frome: https://github.com/svenstaro/upload-release-action
# By LEDE 2020 https://ledewrt.com
# https://github.com/ledewrt
#=================================================
#添加固件版本描述。
#rm -Rf package/diy/luci-app-adguardhome
rm -Rf package/lean/luci-app-wrtbwmon
rm -Rf package/lean/luci-theme-argon
rm -Rf package/diy/OpenAppFilter
# 修改登陆地址
sed -i 's/192.168.1.1/192.168.168.1/g' package/base-files/files/bin/config_generate
# 关闭禁止解析IPv6 DNS 记录
sed -i '/option filter_aaaa 1/d' package/network/services/dnsmasq/files/dhcp.conf

#修改网络连接数
#sed -i 's/net.netfilter.nf_conntrack_max=65535/net.netfilter.nf_conntrack_max=105535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#添加自定义插件1。
git clone https://github.com/vernesong/OpenClash.git package/diy/luci-app-openclash
git clone https://github.com/garypang13/openwrt-adguardhome.git package/diy/openwrt-adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git  package/diy/luci-app-adguardhome
sed -i '/resolvfile=/d' package/diy/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i 's/DEPENDS:=/DEPENDS:=+AdGuardHome /g' package/diy/luci-app-adguardhome/Makefile
#argon主题
svn co https://github.com/god-os/openwrt-app/trunk/luci-theme-argon package/diy/luci-theme-argon
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-eqos package/diy/luci-app-eqos
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-godproxy package/diy/luci-app-godproxy
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-serverchan package/diy/luci-app-serverchan
git clone https://github.com/Lienol/openwrt-OpenAppFilter.git package/diy/OpenAppFilter
#git clone https://github.com/destan19/OpenAppFilter.git package/diy/OpenAppFilter
git clone https://github.com/fw876/helloworld.git package/diy/luci-app-ssr-plus
#git clone https://github.com/docker/docker-ce.git package/diy/luci-app-docker-ce
svn co https://github.com/god-os/openwrt-app/luci-app-jd-dailybonus/branches/luci19  package/diy/luci-app-jd-dailybonus  #京东签到
#git clone https://github.com/tohojo/sqm-scripts.git package/diy/sqm-scripts
#git clone  https://github.com/siwind/luci-app-ttyd.git package/diy/luci-app-ttyd
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-control-webrestriction package/luci-app-control-webrestriction
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-control-timewol package/luci-app-control-timewol
svn co https://github.com/god-os/openwrt-app/trunk//luci-app-control-weburl package/luci-app-control-weburl
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-timecontrol package/luci-app-timecontrol
git clone -b lede https://github.com/pymumu/luci-app-smartdns  package/luci-app-smartdns
git clone https://github.com/garypang13/luci-app-dnsfilter.git package/diy/luci-app-dnsfilter
svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon package/wrtbwmon
svn co https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon

svn co https://github.com/god-os/openwrt-app/trunk/luci-app-uugamebooster package/diy/luci-app-uugamebooster
svn co https://github.com/god-os/openwrt-app/trunk/luci-app-ttnod package/diy/luci-app-ttnode

#cd package
#svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall
#cd -
./scripts/feeds update -a
./scripts/feeds install -a

# 内核显示增加自己个性名称
date=`date +%d.%m.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='GodROS D%C From Lean OpenWrt %V'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
