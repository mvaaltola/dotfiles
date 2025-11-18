#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: athena2geojsonl.sh <input.csv>"
    exit 1
fi

sed "s/^.//g" $1 | sed "s/.$//g" | sed "s/\"\"/\"/g" | tail -n +2 | jq -c '{type, geometry, properties}'
