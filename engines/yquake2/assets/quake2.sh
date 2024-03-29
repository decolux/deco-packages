#!/bin/bash

# Some genius packaging Quake 2 for Steam decided to upload default
# config.cfg as a game file. In result:
# - user settings will be reset when installation files are verified
# - yquake2 default configuration can't override some crucial settings
#
# If the default file is removed, yquake2 will pick up defaults from
# pak files and yq2.cfg correctly.

is_in_default_state () {
	echo "$1  $2" | md5sum --status --check -
}

rm_default_config () {
	local -r checksum=$1
	local -r config=$2
	if [ ! -f "$config" ] ; then
		return
	fi
	if is_in_default_state "$checksum" "$config" ; then
		rm -f "$config"
	fi
}

rm_default_config edee610dd81f6bf8290a8f93fc80c387 baseq2/config.cfg

ARGS=()

for var in "$@"; do
    [ "$var" != 'D:\data\max' ] && ARGS+=("$var")
done

mkdir -p baseq2/music
ln -rsf rerelease/baseq2/music/track02.ogg baseq2/music/02.ogg
ln -rsf rerelease/baseq2/music/track03.ogg baseq2/music/03.ogg
ln -rsf rerelease/baseq2/music/track04.ogg baseq2/music/04.ogg
ln -rsf rerelease/baseq2/music/track05.ogg baseq2/music/05.ogg
ln -rsf rerelease/baseq2/music/track06.ogg baseq2/music/06.ogg
ln -rsf rerelease/baseq2/music/track07.ogg baseq2/music/07.ogg
ln -rsf rerelease/baseq2/music/track08.ogg baseq2/music/08.ogg
ln -rsf rerelease/baseq2/music/track09.ogg baseq2/music/09.ogg
ln -rsf rerelease/baseq2/music/track10.ogg baseq2/music/10.ogg
ln -rsf rerelease/baseq2/music/track11.ogg baseq2/music/11.ogg

mkdir -p rogue/music
ln -rsf rerelease/baseq2/music/track17.ogg rogue/music/02.ogg
ln -rsf rerelease/baseq2/music/track12.ogg rogue/music/03.ogg
ln -rsf rerelease/baseq2/music/track13.ogg rogue/music/04.ogg
ln -rsf rerelease/baseq2/music/track14.ogg rogue/music/05.ogg
ln -rsf rerelease/baseq2/music/track14.ogg rogue/music/06.ogg
ln -rsf rerelease/baseq2/music/track18.ogg rogue/music/07.ogg
ln -rsf rerelease/baseq2/music/track15.ogg rogue/music/08.ogg
ln -rsf rerelease/baseq2/music/track19.ogg rogue/music/09.ogg
ln -rsf rerelease/baseq2/music/track20.ogg rogue/music/10.ogg
ln -rsf rerelease/baseq2/music/track21.ogg rogue/music/11.ogg

mkdir -p xatrix/music
ln -rsf rerelease/baseq2/music/track09.ogg xatrix/music/02.ogg
ln -rsf rerelease/baseq2/music/track12.ogg xatrix/music/03.ogg
ln -rsf rerelease/baseq2/music/track13.ogg xatrix/music/04.ogg
ln -rsf rerelease/baseq2/music/track07.ogg xatrix/music/05.ogg
ln -rsf rerelease/baseq2/music/track14.ogg xatrix/music/06.ogg
ln -rsf rerelease/baseq2/music/track02.ogg xatrix/music/07.ogg
ln -rsf rerelease/baseq2/music/track15.ogg xatrix/music/08.ogg
ln -rsf rerelease/baseq2/music/track03.ogg xatrix/music/09.ogg
ln -rsf rerelease/baseq2/music/track04.ogg xatrix/music/10.ogg
ln -rsf rerelease/baseq2/music/track16.ogg xatrix/music/11.ogg

./quake2 -portable "${ARGS[@]}"
