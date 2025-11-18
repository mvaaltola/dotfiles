#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: geojsonl2geojson.sh <file.json>"
    exit 1
fi

jq -c '.geojson | fromjson' < $1 | \
    sed '$!s/$/,/' | \
    sed '1s/^/{"type": "FeatureCollection", "features": [\n/' && \
    echo ']}'
