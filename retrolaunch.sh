#!/bin/bash

# path to RA cores on macOS
cpath=$HOME/Library/Application\ Support/RetroArch/cores/

# core names
nes=fceumm_libretro.dylib
gbc=gambatte_libretro.dylib
gba=mgba_libretro.dylib
snes=snes9x_libretro.dylib
a26=stella_libretro.dylib
smd=genesis_plus_gx_libretro.dylib
nds=desmume_libretro.dylib
c64=vice_x64_libretro.dylib

for rom in "$@"
do
	romname=$(basename -- "$rom")
	romtype="${romname#*.}"

  # choose core based on rom suffix
	case "$romtype" in
		nes)            core=$nes ;;
		gb|gbc)         core=$gbc ;;
		smc|sfc)        core=$snes ;;
		a26|bin)        core=$a26 ;;
		sms|md|smd|gg)  core=$smd ;;
		nds)            core=$nds ;;
		#d64|t64|prg)    core=$c64 ;;
		*)              core="not yet supported"
	esac

done

# text formatting
temphasis=$(tput bold; tput setaf 13)
tregular=$(tput sgr0)

if [[ "$core" == "not yet supported" ]] then
  echo "Core not yet supportet"
else
  echo "RetroArch: launching $temphasis$romname$tregular rom..."
  open -a RetroArch --args -L "$cpath$core" "$rom"
fi


