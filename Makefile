SHELL := /bin/bash
export PATH := $(PWD)/.venv/bin:$(PATH)

all: help

.PHONY: help
help:  ## List all commands
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9 -_]+:.*?## / {printf "\033[36m%-26s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: install-base-req
install-base-req:  ## Install needed base packages via apt
	sudo apt install python3-pip python3-venv

.PHONY: install
install:  ## Install the project in a Python virtualenv
	python3 -m venv .venv
	.venv/bin/pip install -U pip
	.venv/bin/pip install -U uv
	.venv/bin/uv sync

.PHONY: update-requirements
update-requirements:  ## Update requirements
	python3 -m venv .venv
	.venv/bin/pip install -U pip
	.venv/bin/pip install -U uv
	.venv/bin/uv lock --upgrade
	.venv/bin/uv sync

.PHONY: test
test: ## Run tests
	.venv/bin/python3 -m unittest --verbose --locals

#############################################################################################
# controls-gallery

.PHONY: run-controls-gallery
run-controls-gallery: ## Run the application
	cd controls-gallery && flet run

#############################################################################################
# demo-app

.PHONY: run-demo-app
run-demo-app: ## Run the application
	cd demo-app && \
	watchmedo auto-restart --pattern="*.py" --recursive -- flet run

.PHONY: build-demo-app
build-demo-app: ## Build APK
	cd demo-app && flet build -v apk

.PHONY: adb-install
adb-install: ## Install APK on Android device
	adb devices
	adb install demo-app/build/apk/app-release.apk

.PHONY: adb-logcat
adb-logcat: ## Run adb logcat
	adb logcat

#############################################################################################
# https://flathub.org/apps/com.google.AndroidStudio

.PHONY: android-studio-install
android-studio-install: ## Install Android Studio via Flatpak
	flatpak install flathub com.google.AndroidStudio

.PHONY: android-studio-run
android-studio-run: ## Run Android Studio
	flatpak run com.google.AndroidStudio
