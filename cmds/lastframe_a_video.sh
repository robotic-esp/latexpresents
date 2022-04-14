#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters"
    exit 2
fi

VID="${1}"

if [[ -f ${VID} && "${VID: -3}" != "png" && "${VID: -3}" != "jpg" && "${VID: -3}" != "gif" && "${VID: -3}" != "pdf" ]]; then
    last="${VID%.*}_last.png"
    if [ ! -f "${last}" ]; then
        echo "${VID}: Last framing to ${last}."
        ffmpeg -n -hide_banner -loglevel error -sseof -1 -i "${VID}"  -update 1 "${last}"
    else
        echo "${VID}: Last frame ${last} already exists."
    fi
fi
