XCODE_PATH := $(shell xcode-select -p)
XCODE_TOOLCHAIN := $(XCODE_PATH)/Toolchains/XcodeDefault.xctoolchain
CC := $(shell xcrun -find clang)
CXX := $(shell xcrun -find clang++)

SDKROOT ?= $(shell xcrun --show-sdk-path)
ISYSROOT := $(shell xcrun -sdk macosx --show-sdk-path)
INCLUDE_PATH := $(shell xcrun -sdk macosx --show-sdk-platform-path)/Developer/SDKs/MacOSX.sdk/usr/include

CFLAGS = -Wall -Wextra -O2 \
    -fobjc-arc \
    -isysroot $(SDKROOT) \
    -iframework $(SDKROOT)/System/Library/Frameworks \
    -F/System/Library/PrivateFrameworks \
    -IZKSwizzle
ARCHS = -arch x86_64 -arch arm64 -arch arm64e
FRAMEWORK_PATH = $(SDKROOT)/System/Library/Frameworks
PRIVATE_FRAMEWORK_PATH = $(SDKROOT)/System/Library/PrivateFrameworks
PUBLIC_FRAMEWORKS = -framework Foundation -framework AppKit -framework QuartzCore -framework Cocoa \
    -framework CoreFoundation

PROJECT = Zephyr
DYLIB_NAME = libZephyr.dylib
BUILD_DIR = build
SOURCE_DIR = Zephyr
INSTALL_DIR = /var/ammonia/core/tweaks

DYLIB_SOURCES = $(SOURCE_DIR)/Zephyr.m \
				$(SOURCE_DIR)/ZKSwizzle.m \
				$(SOURCE_DIR)/CALayer+Average.m \
                $(SOURCE_DIR)/JLMaterialLayer/JLMaterialLayer.m
DYLIB_OBJECTS = $(DYLIB_SOURCES:%.m=$(BUILD_DIR)/%.o)

INSTALL_PATH = $(INSTALL_DIR)/$(DYLIB_NAME)
WHITELIST_SOURCE = libZephyr.dylib.whitelist
WHITELIST_DEST = $(INSTALL_DIR)/libZephyr.dylib.whitelist
BLACKLIST_SOURCE = libZephyr.dylib.blacklist
BLACKLIST_DEST = $(INSTALL_DIR)/libZephyr.dylib.blacklist

DYLIB_FLAGS = -dynamiclib \
              -install_name @rpath/$(DYLIB_NAME) \
              -compatibility_version 1.0.0 \
              -current_version 1.0.0

all: clean $(BUILD_DIR)/$(DYLIB_NAME) 

$(BUILD_DIR):
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/Zephyr

$(BUILD_DIR)/%.o: %.m | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(ARCHS) -c $< -o $@

$(BUILD_DIR)/$(DYLIB_NAME): $(DYLIB_OBJECTS)
	$(CC) $(DYLIB_FLAGS) $(ARCHS) $(DYLIB_OBJECTS) -o $@ \
	-F$(FRAMEWORK_PATH) \
	-F$(PRIVATE_FRAMEWORK_PATH) \
	$(PUBLIC_FRAMEWORKS) \
	-L$(SDKROOT)/usr/lib

install: clean $(BUILD_DIR)/$(DYLIB_NAME) 
	sudo mkdir -p $(INSTALL_DIR)
	sudo install -m 755 $(BUILD_DIR)/$(DYLIB_NAME) $(INSTALL_DIR)
	sudo cp $(WHITELIST_SOURCE) $(WHITELIST_DEST); \
	sudo chmod 644 $(WHITELIST_DEST); \
	sudo cp $(BLACKLIST_SOURCE) $(BLACKLIST_DEST); \
	sudo chmod 644 $(BLACKLIST_DEST); \
	pkill -9 "Dock" 2>/dev/null || true

uninstall:
	@sudo rm -f $(INSTALL_PATH)
	@sudo rm -f $(WHITELIST_DEST)
	@sudo rm -f $(BLACKLIST_DEST)
		
clean:
	@rm -rf $(BUILD_DIR)

.PHONY: all clean install uninstall installer 