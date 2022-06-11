#! /bin/bash

app_build_path="./build/linux/x64/release/bundle"

build_mode=$1
app_path=""

if [ "$build_mode" = "local" ] || [[ -z $build_mode ]]; then
	build_mode="local"
	app_path="../app"

elif [ "$build_mode" = "global" ]; then
	scr_path="$HOME/.local/share/nvim/plugged/mkpv.nvim";
	app_path="$scr_path/app";

cp -r ../autoload $scr_path
cp -r ../plugin $scr_path
else 
	echo "
	./build.sh [Mode]

	Mode	Desc
	global	update plug folder
	local	update local folder (default)
	"
	exit 0
fi

echo "Start Build App $build_mode Mode..."

rm -rf $app_path/*

flutter build linux

cp -r ./build/linux/x64/release/bundle $app_path/

dart compile exe ./mkpv/bin/mkpv.dart -o $app_path/mkpv
