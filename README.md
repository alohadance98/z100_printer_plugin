# z100_printer_plugin

A new Flutter plugin project.

## Getting Started

LƯU Ý:
Để chạy được tính năng in khi release:
B1: tạo 1 file proguard ở project và khai báo trong build.gradle ở tầng app.
B2: sửa build.gradle tầng app như sau

buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        // Signing with the debug keys for now, so `flutter run --release` works.
        signingConfig signingConfigs.debug
        shrinkResources false
        minifyEnabled false
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
