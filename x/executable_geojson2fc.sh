#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: geojsonl2fc.sh <file.json>"
    exit 1
fi

sed '$!s/$/,/' $1 | \
    sed '1s/^/{"type": "FeatureCollection", "features": [\n/' && \
    echo ']}'
