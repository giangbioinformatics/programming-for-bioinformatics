#!/bin/bash

# Run CheckM on the SPAdes assembly
checkm lineage_wf -t 4 -x fa spades_assembly/ checkm_output/

# Print the completeness and contamination estimates
cat checkm_output/storage/bin_stats_ext.tsv
