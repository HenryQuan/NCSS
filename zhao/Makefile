TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 1
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = zhao

zhao_FILES = Tweak.x helper/Tools.m
zhao_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

DEB_NAME = package
DEBIAN = $(DEB_NAME)/DEBIAN
DYLIB = $(DEB_NAME)/Library/MobileSubstrate/DynamicLibraries
PREF = $(DEB_NAME)/Library/PreferenceLoader/Preferences
OUTPUT = .theos/obj/arm64/zhao.dylib

# build debug, move to dynamic libraries and respring
move_debug:
	make
	su -c "mv .theos/obj/debug/zhao.dylib /Library/MobileSubstrate/DynamicLibraries"
	killall SpringBoard

# build, package and clean
final:
	make DEBUG=0
	rm -rf $(DEB_NAME)
	mkdir -p $(DEBIAN)
	mkdir -p $(DYLIB)
	mkdir -p $(PREF)
	cp control $(DEBIAN)
	cp $(OUTPUT) $(DYLIB)
	cp zhao.plist $(DYLIB)
	cp pref/* $(PREF)
	dpkg -b $(DEB_NAME)
	rm -rf $(DEB_NAME)