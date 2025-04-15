include $(TOPDIR)/rules.mk

PKG_NAME:=luci-mod-pcatbattery

PKG_VERSION:=1.0.1
PKG_RELEASE:=2

LUCI_TITLE:=LuCI support for Photonicat Battery
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-base +pcat-manager

PKG_MAINTAINER:=Shirona <shirona@ichinomiya.dev>

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
