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

define PIGPIO_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 $(@D)/pigpiod.sh		  $(TARGET_DIR)/etc/init.d/pigpiod
endef

define ALARMPI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 pigpiod.service		  $(TARGET_DIR)/usr/lib/systemd/system/pigpiod.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/
	ln -fs ../../../../usr/lib/systemd/system/pigpiod.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/pigpiod.service
endef

$(eval $(generic-package))
