ALARMPI_VERSION = 3adefddbf4ba677ec8e7aa30999f3fee202e61b0
ALARMPI_SITE = https://github.com/horfee/alarmpi.git
ALARMPI_SITE_METHOD = git
ALARMPI_DEPENDENCIES = libevent wiringpi sqlite openssl pigpio
ALARMPI_INSTALL_STAGING = YES
ALARMPI_INSTALL_TARGET = YES

define ALARMPI_BUILD_CMDS
	ifeq ($(BR2_PACKAGE_ALARMPIUSEWIRINGPI),y)
		TARGET_CFLAGS="$(TARGET_CFLAGS) -DWIRINGPI"
	endif
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" -C $(@D) all
endef

define ALARMPI_INSTALL_STAGING_CMDS
	ifeq ($(BR2_PACKAGE_ALARMPIUSEWIRINGPI),y)
		TARGET_CFLAGS="$(TARGET_CFLAGS) -DWIRINGPI"
	endif
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define ALARMPI_INSTALL_TARGET_CMDS
	ifeq ($(BR2_PACKAGE_ALARMPIUSEWIRINGPI),y)
		TARGET_CFLAGS="$(TARGET_CFLAGS) -DWIRINGPI"
	endif
    $(MAKE) CC="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

define ALARMPI_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 $(@D)/init.d.sh		  $(TARGET_DIR)/etc/init.d/alarmPI
endef

define ALARMPI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0755 $(@D)/alarmPI.service		  $(TARGET_DIR)/usr/lib/systemd/system/alarmPI.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/
	ln -fs ../../../../usr/lib/systemd/system/alarmPI.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/alarmPI.service
endef

$(eval $(generic-package))
