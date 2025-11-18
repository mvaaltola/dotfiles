#!/usr/bin/env python3
import argparse
import json

from pathlib import Path

parser = argparse.ArgumentParser(description="Convert features of a GeoJSON file to JSON objects")
parser.add_argument("geojson", type=str, help="Input GeoJSON file")
parser.add_argument("json", type=str, help="Output JSON file")
args = parser.parse_args()

geojsonp = Path(args.geojson)
if not geojsonp.exists():
    print("error: input geojson file does not exist!")
    exit(1)

jsonp = Path(args.json)
if jsonp.suffix != ".json":
    print("error: output must be a .json file!")
    exit(1)

with open(geojsonp) as geojsonf, open(jsonp, "w") as jsonf:
    j = json.load(geojsonf)
    feats = j["features"]
    for feat in feats:
        row = {"geojson": json.dumps(feat, separators=(",", ":"))}
        json.dump(row, jsonf, separators=(",", ":"))
        jsonf.write("\n")
