ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotFinical

NotFinical_FILES = Tweak.x
NotFinical_CFLAGS = -fobjc-arc

NotFinical_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += notfinicalprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
