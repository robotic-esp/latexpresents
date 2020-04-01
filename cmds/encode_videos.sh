#!/bin/bash

INPUT="${1}"

ls "${INPUT}"

# -g is the key-frame rate, the lower the number, the more keyframes. (e.g., -g X creates a keyframe every X frames).

for vid in "${INPUT}"/*; do
    if [ "${vid: -3}" != "png" ] && [ "${vid: -3}" != "jpg" ] && [ "${vid: -3}" != "gif" ] && [ "${vid: -3}" != "pdf" ]; then
        filename="${vid%.*}"
        if [ "${filename: -4}" != "_enc" ]; then
            # Get the frame rate and evaluate to a real number.
            fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=avg_frame_rate "${vid}")
            # Encode with keyframes at a multiple of it
            ffmpeg -n -i "${vid}" -c:a copy -c:v libx264 -preset veryslow -g "${fps}" "${filename}_enc.mp4" 
        fi
    fi
done
