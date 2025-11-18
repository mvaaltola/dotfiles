#!/usr/bin/env python3
import argparse
import csv
import json

from pathlib import Path
from typing import TypedDict

parser = argparse.ArgumentParser(description="Convert a OSM CSV from Athena to a jsonl file")
parser.add_argument("csv", type=str, help="Athena OSM CSV file")
parser.add_argument("json", type=str, help="Output JSON file")
args = parser.parse_args()

def transform(dict_, typed_dict) -> dict:
    """ Convert values in given dictionary to corresponding types in TypedDict . """
    fields = typed_dict.__annotations__
    # for name, value in dict_.items():
    #     print(name, fields[name](value))
    return {name: fields[name](value) for name, value in dict_.items()}


class CSV_Record_Types(TypedDict):
    """ Define the fields and their types in a record.
        Field names must match column names in CSV file header.
    """
    id: int
    osmium_id: str
    type: str
    tags: str
    changeset: str
    timestamp: str
    version: int
    geojson: str
    dt: str

def parse_osm_tags(tags_str: str) -> dict:
    pass

csvp = Path(args.csv)
if not csvp.exists():
    print("error: input csv file does not exist!")
    exit(1)

jsonp = Path(args.json)
if jsonp.suffix != ".json":
    print("error: output must be a .json file!")
    exit(1)

with open(csvp) as csvf, open(jsonp, 'w') as jsonf:
    for row in csv.DictReader(csvf):
        row = transform(row, CSV_Record_Types)
        row["tags"] = json.loads(row["tags"])
        json.dump(row, jsonf, separators=(",", ":"))
        jsonf.write("\n")
        
    # field_names = ("id","osmium_id","type","tags","changeset","timestamp","version","geojson","dt")
    # reader = csv.DictReader(csvf)
    # for row in reader:
    #     row = Record._transform(row)
    #     json.dump(row, jsonf, separators=(",", ":"))
    #     jsonf.write("\n")
