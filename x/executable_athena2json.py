#!/usr/bin/env python3
import argparse
import csv
import json

from pathlib import Path

parser = argparse.ArgumentParser(description="Convert a result CSV from Athena to a jsonl file")
parser.add_argument("csv", type=str, help="Athena result CSV file")
parser.add_argument("json", type=str, help="Output JSON file")
args = parser.parse_args()

jsonl = []

csvp = Path(args.csv)
if not csvp.exists():
    print("error: input csv file does not exist!")
    exit(1)

jsonp = Path(args.json)
if jsonp.suffix != ".json":
    print("error: output must be a .json file!")
    exit(1)

with open(csvp) as csvf, open(jsonp, "w") as jsonf:
    for row in csv.DictReader(csvf):
        jsonl.append(json.loads(row["geojson"]))

    for row in jsonl:
        row = {"geojson": json.dumps(row, separators=(",", ":"))}
        json.dump(row, jsonf, separators=(",", ":"))
        jsonf.write("\n")
