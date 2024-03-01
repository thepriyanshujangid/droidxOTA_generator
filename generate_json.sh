#!/bin/bash
#put script in DroidX-UIsource folder, make executable (chmod +x file.sh) and run it (./file.sh)

#modify values below
#leave blank if not used
maintainer="PRIYANSHU"
oem="xiaomi"
device="redwood" 
devicename="POCO X5 Pro 5G" 
zip=""
forum=""
gapps=""
recovery="https://sourceforge.net/projects/droidxui-releases/files/redwood/14/recovery"
telegram="thepriyanshujangid"

# Don't modify from here
script_path="`dirname \"$0\"`"
zip_name=out/target/product/$device/$zip
buildprop=out/target/product/$device/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
sha256=`sha256sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
echo '{
  "response": [
    {
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$devicename'",
        "filename": "'$zip_only'",
        "download": "https://sourceforge.net/projects/droidxui-releases/files/'$device'/'$v_max'.x/'$zip_only'/download",
        "timestamp": '$timestamp',
        "sha256": "'$sha256'",
        "size": '$size',
        "forum": "'$forum'",
        "gapps": "'$gapps'",
        "telegram": "'$telegram'"
    }
  ]
}' >> $device.json
