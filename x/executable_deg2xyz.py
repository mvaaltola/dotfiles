#!/usr/bin/env python
import math
import sys


def deg2num(lat_deg: float, lon_deg: float, zoom: int):
  lat_rad = math.radians(lat_deg)
  n = 2.0 ** zoom
  xtile = int((lon_deg + 180.0) / 360.0 * n)
  ytile = int((1.0 - math.asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
  return xtile, ytile

if __name__ == "__main__":
    try:
      if len(sys.argv) != 4:
        print("Convert lat,lon (y,x) coordinates to EPSG:3857 XYZ.")
        print("USAGE: deg2xyz.py lat lon z")
        exit(0)
      lat, lon, z = sys.argv[1:4]
    except ValueError:
      print("error: provide exactly 3 arguments: lat (y), lon (x), and zoomlevel")
      exit(1)

    try:
      lat = float(lat)
      lon = float(lon)
      z = int(z)
    except ValueError:
      print("error: could not cast input to number")
      exit(1)

    x, y = deg2num(lat, lon, z)
    print(f"x: {x}, y: {y}, z: {z}")
