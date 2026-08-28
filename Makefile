ARCHS = arm64
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = lovebypass
lovebypass_FILES = Tweak.x
lovebypass_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
