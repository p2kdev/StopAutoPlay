include $(THEOS)/makefiles/common.mk

export ARCHS=arm64

TWEAK_NAME = StopAutoPlay
StopAutoPlay_FILES = Tweak.xm
StopAutoPlay_FRAMEWORKS = MediaPlayer AVFoundation
StopAutoPlay_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
