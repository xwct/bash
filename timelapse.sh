#! /bin/bash
#set -e
#set -x
set -v

mkdir -p $PWD/cropped
#i=0
#for PIC in $PWD/RAW/*
#do
#    convert "$PIC" -crop 2800x2000+0+0 +repage "cropped/crop_$((i++)).png"
#    echo $1
#done

ls -d -1 $PWD/raw/*.* | parallel -j8 'convert {} -crop 1920x1440+880+0 +repage "cropped/{/}"'

ls $PWD/cropped/*.* | xargs cat - | $PWD/ffmpeg -i - -c:v libx265 -preset slow -crf 32 -vf "fps=25" timelapse.mp4
