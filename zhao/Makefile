TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = zhao

zhao_FILES = Tweak.x helper/app_tool.m
zhao_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

DEB_NAME = package
DEBIAN = $(DEB_NAME)/DEBIAN
DYLIB = $(DEB_NAME)/Library/MobileSubstrate/DynamicLibraries
PREF = $(DEB_NAME)/Library/PreferenceLoader/Preferences
OUTPUT = .theos/obj/zhao.dylib

# bundle
SUBPROJECTS += zhaopref
include $(THEOS_MAKE_PATH)/aggregate.mk

# build debug, move to dynamic libraries and respring
move_debug:
	make
	su -c "mv .theos/obj/debug/zhao.dylib /Library/MobileSubstrate/DynamicLibraries"
	killall SpringBoard
