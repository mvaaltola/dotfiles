#!/usr/bin/env python3

import sys
import os # Import os module to check for piped input

def tsv_to_markdown(input_stream, output_file=None):
    # Read the TSV data from the provided input_stream (file or stdin)
    lines = input_stream.readlines()

    # Remove trailing empty lines
    lines = [line for line in lines if line.strip()]

    # Process the TSV data into a Markdown table format
    if not lines:
        print("The input is empty or contains only empty lines.")
        return

    markdown_lines = []
    headers = lines[0].strip().split('\t')
    markdown_lines.append('| ' + ' | '.join(headers) + ' |')
    markdown_lines.append('| ' + ' | '.join(['---'] * len(headers)) + ' |')

    for line in lines[1:]:
        row = line.strip().split('\t')
        markdown_lines.append('| ' + ' | '.join(row) + ' |')

    markdown_table = '\n'.join(markdown_lines)

    if output_file:
        # Write the Markdown table to the specified output file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(markdown_table)
        print(f"Markdown table written to {output_file}")
    else:
        # Print the Markdown table to stdout
        print(markdown_table)

if __name__ == "__main__":
    input_source = None
    output_file = None

    # Check if input is piped
    if not sys.stdin.isatty():
        input_source = sys.stdin
        # If piped, the first argument (if present) becomes the output file
        if len(sys.argv) > 1:
            output_file = sys.argv[1]
    else:
        # No piped input, expect file arguments
        if len(sys.argv) < 2:
            print("Usage: python tsv2md.py <input_tsv_file> [output_file]")
            print("       Or: <data> | python tsv2md.py [output_file]")
            sys.exit(1)
        
        input_tsv_file = sys.argv[1]
        try:
            input_source = open(input_tsv_file, 'r', encoding='utf-8')
        except FileNotFoundError:
            print(f"Error: Input file '{input_tsv_file}' not found.")
            sys.exit(1)
        except Exception as e:
            print(f"Error opening file '{input_tsv_file}': {e}")
            sys.exit(1)

        output_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    # Call the main function with the appropriate input source
    tsv_to_markdown(input_source, output_file)

    # If we opened a file, make sure to close it
    if input_source != sys.stdin and input_source is not None:
        input_source.close()
