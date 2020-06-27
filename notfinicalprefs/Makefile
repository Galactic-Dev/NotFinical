ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NotFinicalPrefs

NotFinicalPrefs_FILES = NFNRootListController.m
NotFinicalPrefs_INSTALL_PATH = /Library/PreferenceBundles
NotFinicalPrefs_PRIVATE_FRAMEWORKS = Preferences
NotFinicalPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NotFinicalPrefs.plist$(ECHO_END)
