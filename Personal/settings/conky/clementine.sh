#!/bin/sh


#image=`qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep arturl | cut -c16-`
#chanson=`qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep title | cut -c8-`

export DISPLAY=:0

NOWPLAYING=`qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata`

if [ $? = 0 ] && [ -n "$NOWPLAYING" ]; then
	case "$1" in
		album ) echo "$NOWPLAYING" | sed -ne 's/^album: \(.*\)$/\1/p' ;;
		artist ) echo "$NOWPLAYING" | sed -ne 's/^artist: \(.*\)$/\1/p' ;;
		genre ) echo "$NOWPLAYING" | sed -ne 's/^genre: \(.*\)$/\1/p' ;;
		rating ) echo "$NOWPLAYING" | sed -ne 's/^rating: \(.*\)$/\1/p' ;;
		title ) echo "$NOWPLAYING" | sed -ne 's/^title: \(.*\)$/\1/p' ;;
		track ) echo "$NOWPLAYING" | sed -ne 's/^tracknumber: \(.*\)$/\1/p' ;;
		year ) echo "$NOWPLAYING" | sed -ne 's/^year: \(.*\)$/\1/p' ;;
		progress)
		    curr=`qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.PositionGet`
		    tot=`echo "$NOWPLAYING" | sed -ne 's/^mtime: \(.*\)$/\1/p'`
		    echo `expr $curr \* 100  / $tot`
		;;
		pochette)
			image=`qdbus org.mpris.clementine /Player org.freedesktop.MediaPlayer.GetMetadata | grep arturl | cut -c16-`
			cp $image /tmp/cover.jpg
		;;
	esac
fi
