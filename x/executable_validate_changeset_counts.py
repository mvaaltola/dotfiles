#!/usr/bin/env python3
"""
Script to validate changeset feature counts from downloaded S3 files.
Counts creates vs deletes and compares against expected values.
"""

import json
import os
import glob
import argparse
from pathlib import Path

def count_changeset_features(directory_path):
    """
    Count creates and deletes in all changeset files within a directory.

    Args:
        directory_path: Path to directory containing changeset files

    Returns:
        tuple: (creates_count, deletes_count, total_files_processed)
    """
    creates_count = 0
    deletes_count = 0
    files_processed = 0

    # Find all files in the directory (including subdirectories)
    changeset_dir = Path(directory_path)

    if not changeset_dir.exists():
        raise FileNotFoundError(f"Directory not found: {directory_path}")

    # Look for all files (Spark typically creates part-* files)
    pattern = "**/*"
    all_files = list(changeset_dir.glob(pattern))

    # Filter to only process actual data files (not directories, _SUCCESS, etc.)
    data_files = [f for f in all_files if f.is_file() and not f.name.startswith('_') and not f.name.startswith('.')]

    print(f"Found {len(data_files)} data files to process")

    for file_path in data_files:
        print(f"Processing: {file_path}")
        files_processed += 1

        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                for line_num, line in enumerate(f, 1):
                    line = line.strip()
                    if not line:
                        continue

                    try:
                        feature = json.loads(line)

                        # Check if this is a delete operation
                        if feature.get('delete', False):
                            deletes_count += 1
                        else:
                            creates_count += 1

                    except json.JSONDecodeError as e:
                        print(f"Warning: Invalid JSON on line {line_num} in {file_path}: {e}")
                        continue

        except Exception as e:
            print(f"Error processing {file_path}: {e}")
            continue

    return creates_count, deletes_count, files_processed

def main():
    parser = argparse.ArgumentParser(
        description="Validate changeset feature counts from downloaded S3 files."
    )
    parser.add_argument(
        "path",
        type=str,
        help="Path to directory containing changeset files to scan"
    )
    parser.add_argument(
        "--expected-deletes",
        type=int,
        default=None,
        help="Expected number of deletes (optional)"
    )
    parser.add_argument(
        "--expected-creates",
        type=int,
        default=None,
        help="Expected number of creates (optional)"
    )

    args = parser.parse_args()

    changeset_dir = args.path
    expected_deletes = args.expected_deletes
    expected_creates = args.expected_creates

    print("Counting changeset features...")
    print(f"Directory: {changeset_dir}")
    if expected_deletes is not None or expected_creates is not None:
        if expected_deletes is not None:
            print(f"Expected deletes: {expected_deletes:,}")
        if expected_creates is not None:
            print(f"Expected creates: {expected_creates:,}")
    print("-" * 60)

    try:
        creates, deletes, files_processed = count_changeset_features(changeset_dir)

        print(f"\nResults:")
        print(f"Files processed: {files_processed}")
        print(f"Creates found: {creates:,}")
        print(f"Deletes found: {deletes:,}")
        print(f"Total features: {creates + deletes:,}")

        # Only perform validation if expected values were provided
        if expected_deletes is not None or expected_creates is not None:
            print(f"\nValidation:")

            if expected_creates is not None:
                creates_match = creates == expected_creates
                print(f"Creates match expected: {'✓' if creates_match else '✗'} ({creates:,} vs {expected_creates:,})")
                if not creates_match:
                    diff = creates - expected_creates
                    print(f"   Creates difference: {diff:+,}")

            if expected_deletes is not None:
                deletes_match = deletes == expected_deletes
                print(f"Deletes match expected: {'✓' if deletes_match else '✗'} ({deletes:,} vs {expected_deletes:,})")
                if not deletes_match:
                    diff = deletes - expected_deletes
                    print(f"   Deletes difference: {diff:+,}")

            # Check overall success
            all_match = True
            if expected_creates is not None and creates != expected_creates:
                all_match = False
            if expected_deletes is not None and deletes != expected_deletes:
                all_match = False

            if all_match:
                print("\n✅ SUCCESS: All counts match expected values!")
            else:
                print("\n❌ MISMATCH: Counts do not match expected values")

    except Exception as e:
        print(f"Error: {e}")
        return 1

    return 0

if __name__ == "__main__":
    exit(main())