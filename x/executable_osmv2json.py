#!/usr/bin/env python3

import argparse
import csv
import json
import sys

from pathlib import Path

csv.field_size_limit(sys.maxsize)

parser = argparse.ArgumentParser(description="Convert a osm_validated_source Athena result CSV to a jsonl file")
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
        row["id"] = int(row["id"])
        row["tags"] = json.loads(row["tags"])
        jsonl.append(json.dumps(row, separators=(",", ":")))

    for row in jsonl:
        jsonf.write(row)
        jsonf.write("\n")
