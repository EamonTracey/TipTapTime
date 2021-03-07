ARCHS = arm64 arm64e

TARGET := iphone:clang:13.7:13.0
PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TipTapTime

TipTapTime_FILES = $(shell find Sources/TipTapTime -name "*.swift") $(shell find Sources/TipTapTimeC -name "*.m")
TipTapTime_SWIFTFLAGS = -ISources/TipTapTimeC/include
TipTapTime_CFLAGS = -fobjc-arc
TipTapTime_FRAMEWORKS = NomaePreferences

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += TipTapTimePreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
