TARGET := iphone:clang:latest:7.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ZHAOPref

ZHAOPref_FILES = HQRootListController.m
ZHAOPref_FRAMEWORKS = UIKit
ZHAOPref_PRIVATE_FRAMEWORKS = Preferences
ZHAOPref_INSTALL_PATH = /Library/PreferenceBundles
ZHAOPref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
