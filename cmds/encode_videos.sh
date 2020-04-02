#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters"
    exit 2
fi

INPUT="${1%/*}"

# -g is the key-frame rate, the lower the number, the more keyframes. (e.g., -g X creates a keyframe every X frames).

# Make a src folder, regardless of whether it already exists
mkdir -p "${INPUT}/src"

for vid in "${INPUT}"/*; do
    if [[ -f ${vid} && "${vid: -3}" != "png" && "${vid: -3}" != "jpg" && "${vid: -3}" != "gif" && "${vid: -3}" != "pdf" ]]; then
        srcvid="${INPUT}/src/${vid#${INPUT}/}"
        filename="${vid%.*}_enc.mp4"
        trgtvid="${INPUT}/${filename#${INPUT}/}"

        # A video can only be reencoded iff (i) its name does not suggest it was previously reencoded (ii) it can safely be copied to src/ (iii) the target reencoded file name is available
        if [[ "${vid: -8}" != "_enc.mp4" && ! -f "${srcvid}" && ! -f "${trgtvid}" ]]; then
            echo "${vid}:"
            echo "    Moving ${vid} to ${srcvid}."
            mv -n "${vid}" "${srcvid}"

            echo "    Encoding ${srcvid} to ${trgtvid}."
            # Get the frame rate and evaluate to a real number.
            fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=avg_frame_rate "${srcvid}")
            # Encode with keyframes at a multiple of it
            # Preserving audio            
            ffmpeg -n -hide_banner -loglevel error -i "${srcvid}" -c:a copy -c:v libx264 -preset veryslow -g "${fps}" "${trgtvid}" 
            # Removing audio
            # ffmpeg -n -nostats -i "${vid}" -an -c:v libx264 -preset veryslow -g "${fps}" "${trgtvid}"
        elif [[ "${vid: -8}" == "_enc.mp4" ]]; then
            echo "${vid}: Video appears to already be reencoded, will not proceed."
        elif [[ -f "${srcvid}" ]]; then
            echo "${vid}: Backup copy ${srcvid} already exists, cannot proceed."
        elif [[ -f "${trgtvid}" ]]; then
            echo "${vid}: Target ${trgtvid} already exists, cannot proceed."
        fi
    fi
done