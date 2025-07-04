# PyDDF spring sprint 2025

* https://www.pyddf.de/
* https://www.meetup.com/python-meeting-dusseldorf/events/307026678/

## Playing with flet

* https://flet.dev
* https://github.com/flet-dev/flet


### learnings

On modern linux systems the `/lib/x86_64-linux-gnu/libmpv.so.1` is missing,
Work-a-round: Just link `libmpv.so.2` to `libmpv.so.1` ;)

* 16GB RAM is not enough ;)
* very big initial downloads ~13GB
* very long build time for the APK (initial build ~20min, incremental builds >1min)
* flet bugs:
  * include external Python packages doesn't work yet
  * include flet [optional deps](https://flet.dev/docs/publish#including-optional-controls) doesn't work, too
* building on windows has several issues.
* Easiest way to run a Android emulator is flatpak: https://flathub.org/apps/com.google.AndroidStudio


### Makefile

```
$ make
help                       List all commands
install-base-req           Install needed base packages via apt
install                    Install the project in a Python virtualenv
update-requirements        Update requirements
test                       Run tests
run-controls-gallery       Run the application
run-demo-app               Run the application
build-demo-app             Build APK
adb-install                Install APK on Android device
adb-logcat                 Run adb logcat
android-studio-install     Install Android Studio via Flatpak
android-studio-run         Run Android Studio
```

## screenshots

`make run-demo-app`

![2025-05-25_16-25.png](https://github.com/jedie/pyddf-flet-test/blob/main/screenshots/2025-05-25_16-25.png?raw=true "2025-05-25_16-25.png")

Android Emulation:

![2025-05-25_16-43.png](https://github.com/jedie/pyddf-flet-test/blob/main/screenshots/2025-05-25_16-43.png?raw=true "2025-05-25_16-43.png")

