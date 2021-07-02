BINARY?=register_devices_for_txt
PROJECT?=register_devices_for_txt
BUILD_FOLDER?=.build
PREFIX?=/usr/local
RELEASE_BINARY_FOLDER?=$(BUILD_FOLDER)/release/$(PROJECT)

update:
	swift package update

build:
	swift build -c release

clean:
	swift package clean

install: update build
	mkdir -p $(PREFIX)/bin
	cp -f $(RELEASE_BINARY_FOLDER) $(PREFIX)/bin/$(BINARY)

uninstall:
	rm -f $(PREFIX)/bin/$(BINARY)