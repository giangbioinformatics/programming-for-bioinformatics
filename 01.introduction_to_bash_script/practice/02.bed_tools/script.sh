# 06. Bedtools:
Write a bash script that uses the command-line tool bedtools to intersect two sets of genomic intervals, such as ChIP-seq peaks and gene promoters.
Move to NCBI search for bed file to test the script below.
For more detail : https://bedtools.readthedocs.io/en/latest/
```

#!/bin/bash
# Install
# One command
# debian based (Ubuntu/Linux Mint)
sudo apt-get install bedtools
# Check tool location
which bedtools
# /usr/bin/bedtools
# Check tool funcition
bedtools --help

# Install by load source and build compile the scripts into binary (similar to .exe in Window)
# It is good for personal use, don't need to add to bin which required the root previliages
wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz
tar -zxvf bedtools-2.29.1.tar.gz
cd bedtools2
# Compile
make 
# Export tool to use
echo $PATH
# This one will not work well because it will load based on the tools with similar names on their first export
export PATH=$PATH:/home/nguyen/Desktop/Projects/programming-for-bioinformatics/01.introduction_to_bash_script/practice/02.bed_tools/bedtools2/bin
# This one will work better
export PATH=/home/nguyen/Desktop/Projects/programming-for-bioinformatics/01.introduction_to_bash_script/practice/02.bed_tools/bedtools2/bin:$PATH


# Download example, extract and remove compressed file
cd ..
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/maurano.dnaseI.tgz
tar -zxvf maurano.dnaseI.tgz
# rm maurano.dnaseI.tgz # comment because I will run successfully before deleting it permernently
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/cpg.bed
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/exons.bed
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/gwas.bed
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/genome.txt
curl -O https://s3.amazonaws.com/bedtools-tutorials/web/hesc.chromHmm.bed


# Intersect
bedtools intersect -a cpg.bed -b exons.bed | head -5
chr1    29320   29370   CpG:_116
chr1    135124  135563  CpG:_30
chr1    327790  328229  CpG:_29
chr1    327790  328229  CpG:_29
chr1    327790  328229  CpG:_29
# Similar for counting the overlaping features
bedtools intersect -a cpg.bed -b exons.bed | head -5
chr1    29320   29370   CpG:_116
chr1    135124  135563  CpG:_30
chr1    327790  328229  CpG:_29
chr1    327790  328229  CpG:_29
chr1    327790  328229  CpG:_2

# genome coverage
bedtools genomecov -i exons.bed -g genome.txt|head


# Set the file names for the two sets of genomic intervals
PEAKS_FILE="peaks.bed"
PROMOTERS_FILE="promoters.bed"


# Use bedtools to intersect the two sets of genomic intervals and output the results to a new file
bedtools intersect -a "$PEAKS_FILE" -b "$PROMOTERS_FILE" > intersect.bed

# Count the number of intersecting intervals
INTERSECTION_COUNT=$(wc -l < intersect.bed)

# Print the number of intersecting intervals to the screen
echo "The number of intersecting intervals is: $INTERSECTION_COUNT"
```