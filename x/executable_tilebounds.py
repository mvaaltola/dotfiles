#!/usr/bin/env python3
"""
Generate GeoJSON polygon(s) for Web Mercator tile bounds.

Usage:
    python tilebounds.py 16/123/456
    python tilebounds.py 16/123/456 -a 1
    python tilebounds.py 16/123/456 -b 2
    python tilebounds.py 16/123/456 -a 1 -b 2
"""

import argparse
import json
import math
import sys


def tile_to_bounds(z, x, y):
    """
    Convert tile coordinates to geographic bounds (lon/lat).

    Returns:
        tuple: (min_lon, min_lat, max_lon, max_lat)
    """
    n = 2.0 ** z

    # Longitude is straightforward
    lon_left = (x / n) * 360.0 - 180.0
    lon_right = ((x + 1) / n) * 360.0 - 180.0

    # Latitude uses Mercator projection inverse
    def tile_y_to_lat(y, z):
        n = 2.0 ** z
        lat_rad = math.atan(math.sinh(math.pi * (1 - 2 * y / n)))
        return math.degrees(lat_rad)

    lat_top = tile_y_to_lat(y, z)
    lat_bottom = tile_y_to_lat(y + 1, z)

    return (lon_left, lat_bottom, lon_right, lat_top)


def bounds_to_polygon(bounds):
    """
    Convert bounds to GeoJSON polygon coordinates.

    Args:
        bounds: tuple of (min_lon, min_lat, max_lon, max_lat)

    Returns:
        list: GeoJSON polygon coordinates (closed ring)
    """
    min_lon, min_lat, max_lon, max_lat = bounds

    # Create a closed ring (counterclockwise)
    return [[
        [min_lon, min_lat],
        [max_lon, min_lat],
        [max_lon, max_lat],
        [min_lon, max_lat],
        [min_lon, min_lat]
    ]]


def buffer_bounds(bounds, percent):
    """
    Expand bounds by a given percentage on all sides.

    Args:
        bounds: tuple of (min_lon, min_lat, max_lon, max_lat)
        percent: percentage to buffer (e.g., 2 for 2%)

    Returns:
        tuple: buffered (min_lon, min_lat, max_lon, max_lat)
    """
    min_lon, min_lat, max_lon, max_lat = bounds

    # Calculate the buffer amount for each dimension
    lon_range = max_lon - min_lon
    lat_range = max_lat - min_lat

    lon_buffer = lon_range * (percent / 100.0)
    lat_buffer = lat_range * (percent / 100.0)

    # Apply buffer
    return (
        min_lon - lon_buffer,
        min_lat - lat_buffer,
        max_lon + lon_buffer,
        max_lat + lat_buffer
    )


def create_tile_feature(z, x, y, buffer_percent=None):
    """
    Create a GeoJSON feature for a tile.

    Args:
        z: zoom level
        x: tile x coordinate
        y: tile y coordinate
        buffer_percent: optional percentage to buffer the tile bounds

    Returns:
        dict: GeoJSON feature
    """
    bounds = tile_to_bounds(z, x, y)

    # Apply buffer if specified
    if buffer_percent is not None and buffer_percent > 0:
        bounds = buffer_bounds(bounds, buffer_percent)

    polygon_coords = bounds_to_polygon(bounds)

    return {
        "type": "Feature",
        "id": f"{z}/{x}/{y}",
        "properties": {
            "z": z,
            "x": x,
            "y": y
        },
        "geometry": {
            "type": "Polygon",
            "coordinates": polygon_coords
        }
    }


def parse_tile_string(tile_str):
    """
    Parse a tile string in format z/x/y.

    Args:
        tile_str: string in format "z/x/y"

    Returns:
        tuple: (z, x, y) as integers

    Raises:
        ValueError: if format is invalid
    """
    parts = tile_str.split('/')
    if len(parts) != 3:
        raise ValueError(f"Invalid tile format '{tile_str}'. Expected format: z/x/y")

    try:
        z, x, y = int(parts[0]), int(parts[1]), int(parts[2])
    except ValueError:
        raise ValueError(f"Tile coordinates must be integers: {tile_str}")

    return z, x, y


def generate_area_tiles(z, x, y, area):
    """
    Generate list of tiles in an area around the center tile.

    Args:
        z: zoom level
        x: center tile x coordinate
        y: center tile y coordinate
        area: number of tiles to include on each side

    Returns:
        list: list of (z, x, y) tuples
    """
    tiles = []
    for dx in range(-area, area + 1):
        for dy in range(-area, area + 1):
            tiles.append((z, x + dx, y + dy))
    return tiles


def main():
    parser = argparse.ArgumentParser(
        description='Generate GeoJSON polygon(s) for Web Mercator tile bounds.'
    )
    parser.add_argument(
        'tile',
        help='Tile coordinates in format z/x/y (e.g., 16/123/456)'
    )
    parser.add_argument(
        '-a', '--area',
        type=int,
        default=0,
        help='Number of tiles to include on each side (default: 0)'
    )
    parser.add_argument(
        '-b', '--buffer',
        type=float,
        default=0,
        help='Percentage to buffer each tile bounds (default: 0)'
    )

    args = parser.parse_args()

    # Parse the tile coordinates
    try:
        z, x, y = parse_tile_string(args.tile)
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    # Generate tile list
    if args.area > 0:
        tiles = generate_area_tiles(z, x, y, args.area)
    else:
        tiles = [(z, x, y)]

    # Create GeoJSON features
    features = []
    buffer_percent = args.buffer if args.buffer > 0 else None
    for tile_z, tile_x, tile_y in tiles:
        features.append(create_tile_feature(tile_z, tile_x, tile_y, buffer_percent))

    # Create GeoJSON FeatureCollection
    geojson = {
        "type": "FeatureCollection",
        "features": features
    }

    # Write to file
    if args.buffer > 0:
        # Format buffer as integer if it's a whole number, otherwise use float
        buffer_str = str(int(args.buffer)) if args.buffer == int(args.buffer) else str(args.buffer)
        output_filename = f"{z}_{x}_{y}+{buffer_str}.geojson"
    else:
        output_filename = f"{z}_{x}_{y}.geojson"

    with open(output_filename, 'w') as f:
        json.dump(geojson, f, indent=2)

    print(f"Generated {output_filename} with {len(features)} feature(s)")


if __name__ == '__main__':
    main()
