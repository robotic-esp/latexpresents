#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters"
    exit 2
fi

INPUT="${1%/*}"

for vid in "${INPUT}"/*; do
    if [[ -f ${vid} && "${vid: -3}" != "png" && "${vid: -3}" != "jpg" && "${vid: -3}" != "gif" && "${vid: -3}" != "pdf" ]]; then
        thumb="${vid%.*}.png"
        if [ ! -f "${thumb}" ]; then
            echo "${vid}: Thumbnailing to ${thumb}."
            ffmpeg -n -hide_banner -loglevel error -i "${vid}" -vframes 1 "${thumb}"
        else
            echo "${vid}: Thumbnail ${thumb} already exists."
        fi
    fi
done