# luci-theme-darkmatter
# 		Copyright 2017 chrono <https://apollo.open-resource.org>
#
# Darkmatter is an alternative HTML5 theme for LuCI that has evolved from
# luci-theme-bootstrap & luci-theme-material, in an attempt to bring a more
# concise, clean and visually pleasing UX to LEDE/OpenWRT.
#
# Have a bug? Please create an issue here on GitHub!
# 		https://github.com/apollo-ng/luci-theme-darkmatter/issues
#
# luci-theme-material
# 		Copyright 2015 Lutty Yang <lutty@wcan.in>
# luci-theme-bootstrap:
# 		Copyright 2008 Steven Barth <steven@midlink.org>
# 		Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
# 		Copyright 2012 David Menting <david@nut-bolt.nl>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

include $(TOPDIR)/rules.mk

THEME_NAME:=darkmatter
THEME_TITLE:=Darkmatter

PKG_NAME:=luci-theme-$(THEME_NAME)
PKG_VERSION:=0.1.77
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-theme-$(THEME_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=4. Themes
  DEPENDS:=+libc
  TITLE:=$(THEME_TITLE) Theme
  URL:=https://github.com/apollo-ng/luci-theme-darkmatter
  PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-theme-$(THEME_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	echo "uci set luci.themes.$(THEME_TITLE)=/luci-static/$(THEME_NAME); uci commit luci" > $(1)/etc/uci-defaults/luci-theme-$(THEME_NAME)
	$(INSTALL_DIR) $(1)/www/luci-static/$(THEME_NAME)
	$(CP) -a ./files/htdocs/* $(1)/www/luci-static/$(THEME_NAME)/ 2>/dev/null || true
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)
	$(CP) -a ./files/templates/* $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)/ 2>/dev/null || true
endef

define Package/luci-theme-$(THEME_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-theme-$(THEME_NAME) ) && rm -f /etc/uci-defaults/luci-theme-$(THEME_NAME)
}
endef

$(eval $(call BuildPackage,luci-theme-$(THEME_NAME)))
