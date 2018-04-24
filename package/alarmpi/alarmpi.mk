ALARMPI_VERSION = 1802c0c9a3f9c2297f9bc3f2bec8fcf7710c6359
ALARMPI_SITE = https://github.com/horfee/alarmpi.git
ALARMPI_SITE_METHOD = git
ALARMPI_DEPENDENCIES = libevent sqlite openssl hostapd wpa_supplicant
ALARMPI_INSTALL_STAGING = YES
ALARMPI_INSTALL_TARGET = YES

ifeq ($(BR2_PACKAGE_ALARMPIUSEWIRINGPI),y)
	define WIRINGPI
	define RPI
	TARGET_CFLAGS+=-DRPI -DWIRINGPI
else
	define RPI
	TARGET_CFLAGS+=-DRPI
endif
	
define ALARMPI_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" -C $(@D) all
endef

define ALARMPI_INSTALL_STAGING_CMDS
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define ALARMPI_INSTALL_TARGET_CMDS
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" DESTDIR=$(TARGET_DIR) -C $(@D) install
    
endef

define ALARMPI_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 $(@D)/init.d.sh		  $(TARGET_DIR)/etc/init.d/alarmPI
endef

define ALARMPI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 $(@D)/alarmPI.service		  $(TARGET_DIR)/usr/lib/systemd/system/alarmPI.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/
	ln -fs ../../../../usr/lib/systemd/system/alarmPI.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/alarmPI.service
endef

$(eval $(generic-package))
