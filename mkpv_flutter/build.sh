#! /bin/bash

echo "build flutter mkpv..."

flutter build linux

rm -rf ../app/bundle

cp -r ./build/linux/x64/release/bundle ../app/

dart compile exe ./mkpv/bin/mkpv.dart -o ../app/mkpv




