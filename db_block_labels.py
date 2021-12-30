#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

'''
Print a data block with the DB directive taking into account a
list of labels

(c) 2021 Miguel Colom
http://mcolom.info
'''

# run db_block_labels.py dis/a.bin dis/gi_scenario_labels.txt --offset 0 --start 23003 --end 30310

import argparse
import struct
import sys

description = "Print a data block with the DB directive"
epilog = '(C) Miguel Colom, GNU GPL3 license. http://mcolom.info'

"""
parser = argparse.ArgumentParser(description=description, epilog=epilog)
parser.add_argument("input")
parser.add_argument("labels")
parser.add_argument("--offset", default=0x8000, type=int)
parser.add_argument("--start", default=0xB574, type=int)
parser.add_argument("--end", default=0xB673, type=int)
parser.parse_args()
args = parser.parse_args()

# Read arguments
input_filename = args.input
labels_filename = args.labels
offset = args.offset
start = args.start
end = args.end
"""

input_filename = "dis/a_OK.bin"
labels_filename = "dis/gi_scenario_labels.txt"
offset = 0
start = 23003
end = 30309



# Read labels
labels_addrs = set()
with open(labels_filename, 'rt') as f:
    lines = f.readlines()

for line in lines:
    s = line.strip()
    addr = int(s[1:-1], base=16)
    labels_addrs.add(addr)
    

# Read bytes
with open(input_filename, 'rb') as f:
	f.seek(start - offset)
	data = f.read(end-start+1)

num_bytes = int(end-start+1) 

labels = {}

i = 0
while i < len(data):
	values_lines = []
	while i < len(data) and len(values_lines) < 8:


		addr = start + i
		if addr in labels_addrs:
			label_name = f"SCENARIO_TILEMAP_ZONE_{len(labels)+1}"
			labels[label_name] = addr

			labels_addrs.remove(addr)
			break
		else:
			label_name = None

		values_lines.append(f"0x{data[i]:02x}")
		i += 1


	if len(values_lines) > 0:
		print("db " + ", ".join(values_lines) + f"\t; {hex(addr - len(values_lines) + 1)}")

	if label_name:
		print(f"\n{label_name}: ; {hex(addr)}")
		
# EQUs
print("\n\n")
for label_name, addr in labels.items():
	#print(f";{label_name}: EQU {hex(addr)}")

	search_string = f"l{addr:04x}h"
	print(f"sed -i 's/{search_string}/{label_name}/' joint_test.asm")