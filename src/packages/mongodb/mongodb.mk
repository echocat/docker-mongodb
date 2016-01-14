MONGODB_VERSION = HAVE_TO_BE_SET
MONGODB_SOURCE = mongodb-src-r$(MONGODB_VERSION).tar.gz
MONGODB_SITE = https://fastdl.mongodb.org/src
MONGODB_LICENSE = AGPL-3.0
MONGODB_LICENSE_FILES = GNU-AGPL-3.0.txt
MONGODB_DEPENDENCIES = host-scons host-pkgconf host-python host-bzip2 host-zlib

MONGODB_LDFLAGS = $(TARGET_LDFLAGS)

MONGODB_SCONS_ENV = $(TARGET_CONFIGURE_OPTS)

MONGODB_SCONS_OPTS = \
	--debug=stacktrace \
	--debug=findlibs \
	CPPPATH="$(STAGING_DIR)/usr/include" \
	LIBPATH="$(STAGING_DIR)/usr/lib" \
	CC="$(TARGET_CC)" \
	CXX="$(TARGET_CXX)" \
	CFLAGS="$(TARGET_CFLAGS) -DDO_NOT_SHOW_IS_ROOT_WARNINGS" \
	CXXFLAGS="$(TARGET_CXXFLAGS) -DDO_NOT_SHOW_IS_ROOT_WARNINGS" \
	--disable-warnings-as-errors \
	--prefix"=$(TARGET_DIR)"

#MONGODB_SCONS_OPTS = \
#	--debug=stacktrace\
#	--debug=findlibs\
#	--cpppath=$(STAGING_DIR)/usr/include \
#	--libpath=$(STAGING_DIR)/usr/lib\
#	--disable-warnings-as-errors\
#	--prefix=$(TARGET_DIR)

ifeq ($(BR2_PACKAGE_OPENSSL),y)
	MONGODB_DEPENDENCIES += openssl
	MONGODB_SCONS_OPTS += --ssl
endif

MONGODB_SCONS_ENV += LDFLAGS="$(MONGODB_LDFLAGS)"

define MONGODB_BUILD_CMDS
	(cd $(@D); \
		$(MONGODB_SCONS_ENV) \
		$(SCONS) \
		$(MONGODB_SCONS_OPTS) \
		core \
		)
endef

define MONGODB_INSTALL_TARGET_CMDS
	(cd $(@D); \
		$(MONGODB_SCONS_ENV) \
		$(SCONS) \
		$(MONGODB_SCONS_OPTS) \
		install \
		)
endef

$(eval $(generic-package))
