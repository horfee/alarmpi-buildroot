ALARMPI_VERSION = 3adefddbf4ba677ec8e7aa30999f3fee202e61b0
ALARMPI_SITE = https://github.com/horfee/alarmpi.git
ALARMPI_SITE_METHOD = git

ALARMPI_INSTALL_STAGING = YES

define ALARMPI_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CXX)" -C $(@D) all
endef

define ALARMPI_INSTALL_STAGING_CMDS
    $(MAKE) CC="$(TARGET_CXX)" DESTDIR=$(STAGING_DIR) -C $(@D) install
endef

define ALARMPI_INSTALL_TARGET_CMDS
    $(MAKE) CC="$(TARGET_CXX)" DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
