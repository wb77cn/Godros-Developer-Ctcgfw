#!/bin/bash
#!/bin/bash
# 修改主机名字
#sed -i 's/OpenWrt/LEDE/g' package/base-files/files/bin/config_generate
#添加img编译时间前缀。
sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(shell date +%Y%m%d)-Lede-Developer-/g' include/image.mk
# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=4.14/KERNEL_PATCHVER:=4.19/g' target/linux/x86/Makefile


svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-dockerman  package/diy/luci-app-dockerman
svn export --force https://github.com/godros/openwrt-app/branches/luci19/docker package/diy/docker
svn export --force https://github.com/godros/openwrt-app/branches/luci19/dockerd package/diy/dockerd
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-lib-docker  package/diy/luci-lib-docker
svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-compat package/diy/luci-compat

svn export --force https://github.com/godros/openwrt-app/branches/luci19/luci-app-openclash package/diy/luci-app-openclash
svn export --force https://github.com/godros/openwrt-app/branches/luci19/ruby  package/diy/ruby 
svn export --force https://github.com/godros/openwrt-app/branches/luci19/ruby-yaml package/diy/ruby-yaml
svn export --force https://github.com/godros/openwrt-app/branches/luci19/r8168  package/diy/r8168
