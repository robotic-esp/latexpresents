#!/bin/bash

INPUT="${1}"

ls "${INPUT}"

for vid in "${INPUT}"/*; do
    if [ "${vid: -3}" != "png" ] && [ "${vid: -3}" != "jpg" ] && [ "${vid: -3}" != "gif" ] && [ "${vid: -3}" != "pdf" ]; then
        ffmpeg -n -i "${vid}" -vframes 1 "${vid%.*}.png"
    fi
done
