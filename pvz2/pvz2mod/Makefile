TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = pvz2mod

pvz2mod_FILES = PVZRootListController.m
pvz2mod_FRAMEWORKS = UIKit
pvz2mod_PRIVATE_FRAMEWORKS = Preferences
pvz2mod_INSTALL_PATH = /Library/PreferenceBundles
pvz2mod_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
