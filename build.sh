#!/bin/bash

flutter build apk

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore vivi-truco.keystore build/app/outputs/flutter-apk/app-release.apk vivi-truco -keypass senha123 -storepass senha123
zipalign -v 4 ${PATH_APK}/app-release-unsigned.apk ${PATH_APK}/iplugged-gestor-${CLIENTE}.apk