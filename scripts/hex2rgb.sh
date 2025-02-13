#!/bin/bash
hex="${1}"
printf "R: %d G: %d B: %d\n" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
