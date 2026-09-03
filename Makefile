.PHONY: build dev format

build:
	flutter build web

dev:
	flutter run -d web-server --web-port 5555 

format:
	dart format .