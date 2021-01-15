#!/bin/bash

flutter build apk

## keytool -genkey -v -keystore vivi-truco.keystore -alias vivi-truco -keyalg RSA -keysize 2048 -validity 10000 -keypass senha123 -storepass senha123 -dname "CN=vivi.com.br"

#jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore vivi-truco.keystore build/app/outputs/flutter-apk/app-release.apk vivi-truco -keypass senha123 -storepass senha123

#rm build/app/outputs/flutter-apk/app-truco.apk
#zipalign -v 4 build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-truco.apk
