include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:9.3:9.0

export ARCHS = arm64

BUNDLE_NAME = StopAutoPlay
StopAutoPlay_FILES = StopAutoPlay.m
StopAutoPlay_INSTALL_PATH = /Library/PreferenceBundles
StopAutoPlay_FRAMEWORKS = UIKit CoreGraphics QuartzCore
StopAutoPlay_PRIVATE_FRAMEWORKS = Preferences
StopAutoPlay_CFLAGS = -Wno-deprecated-declarations
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/StopAutoPlay.plist$(ECHO_END)
