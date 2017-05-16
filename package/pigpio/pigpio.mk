#
# helloworld
# basic building rules
#
PIGPIO_VERSION = f032029bf9cda3755c62fc69d3a5fc2f566b7ea3
PIGPIO_SITE = git://github.com/joan2937/pigpio
PIGPIO_SITE_METHOD = git

PIGPIO_INSTALL_STAGING = YES
PIGPIO_INSTALL_TARGET = YES

define PIGPIO_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" INSTALL="$(INSTALL)" AR="$(TARGET_CROSS)ar" RANLIB="$(TARGET_CROSS)ranlib" SIZE="$(TARGET_CROSS)size" STRIP="$(TARGET_CROSS)strip" LD="$(TARGET_LD)" -C $(@D) all
endef

define PIGPIO_INSTALL_STAGING_CMDS
    $(MAKE) CC="$(TARGET_CC)" INSTALL="$(INSTALL)" AR="$(TARGET_CROSS)ar" RANLIB="$(TARGET_CROSS)ranlib" SIZE="$(TARGET_CROSS)size" STRIP="$(TARGET_CROSS)strip" LD="$(TARGET_LD)" LDCONFIG="$(TARGET_CROSS)ldconfig" DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define PIGPIO_INSTALL_TARGET_CMDS
    $(MAKE) CC="$(TARGET_CC)" INSTALL="$(INSTALL)" AR="$(TARGET_CROSS)ar" RANLIB="$(TARGET_CROSS)ranlib" SIZE="$(TARGET_CROSS)size" STRIP="$(TARGET_CROSS)strip" LD="$(TARGET_LD)" LDCONFIG="$(TARGET_CROSS)ldconfig" DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

#$(eval $(autotools-package))
#$(eval $(call GENTARGETS,package,pigpio))
$(eval $(generic-package))
