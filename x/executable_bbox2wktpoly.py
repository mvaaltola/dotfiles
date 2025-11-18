#!/usr/bin/env python3

import argparse

def bbox_to_wkt_polygon(bbox):
    """
    Convert a bounding box to WKT polygon.

    Parameters:
    bbox (tuple): A tuple containing (west, south, east, north) coordinates.

    Returns:
    str: WKT representation of the polygon.
    """
    west, south, east, north = bbox
    
    # Create the WKT polygon string
    wkt_polygon = f"POLYGON(({west} {south}, {east} {south}, {east} {north}, {west} {north}, {west} {south}))"
    
    return wkt_polygon

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description='Convert a bounding box to WKT polygon.')
    parser.add_argument('west', type=float, help='West longitude')
    parser.add_argument('south', type=float, help='South latitude')
    parser.add_argument('east', type=float, help='East longitude')
    parser.add_argument('north', type=float, help='North latitude')

    # Parse the arguments
    args = parser.parse_args()

    # Create the bounding box tuple
    bbox = (args.west, args.south, args.east, args.north)

    # Convert to WKT polygon and print
    wkt_polygon = bbox_to_wkt_polygon(bbox)
    print(wkt_polygon)

if __name__ == "__main__":
    main()
