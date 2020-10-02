TARGET := iphone:clang:latest:7.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = pvz2

pvz2_FILES = Tweak.x
pvz2_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
