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
rm -Rf package/lean/luci-app-wrtbwmon
rm -Rf package/lean/luci-theme-argon
rm -Rf package/lean/mwan3
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
svn export --force https://github.com/godros/openwrt-app/branches/luci18/luci-theme-argon package/diy/luci-theme-argon
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-eqos package/diy/luci-app-eqos
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-godproxy package/diy/luci-app-godproxy
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-serverchan package/diy/luci-app-serverchan
git clone https://github.com/destan19/OpenAppFilter.git package/diy/OpenAppFilter
svn export --force https://github.com/godros/openwrt-app/luci-app-jd-dailybonus/branches/luci19  package/diy/luci-app-jd-dailybonus  #京东签到
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-control-webrestriction package/diy/luci-app-control-webrestriction
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-control-timewol package/diy/luci-app-control-timewol
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-control-weburl package/diy/luci-app-control-weburl
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-timecontrol package/diy/luci-app-timecontrol
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-smartdns  package/diy/luci-app-smartdns
svn export --force https://github.com/godros/openwrt-app/branches/luci19/smartdns package/diy/smartdns
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-dnsfilter package/diy/luci-app-dnsfilter
#svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon package/wrtbwmon
#svn co https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon

svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-uugamebooster  package/diy/luci-app-uugamebooster
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-ttnod  package/diy/luci-app-ttnode
svn export --force https://github.com/godros/openwrt-app/branches/luci19/mwan3  package/diy/mwan3


#cd package
#svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall
#cd -
./scripts/feeds update -a
./scripts/feeds install -a

# 内核显示增加自己个性名称
date=`date +%d.%m.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='LedeOS D%C From Lean De OpenWrt Source'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
