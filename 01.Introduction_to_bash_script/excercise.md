# 01. Download fastq file and make the quality control using fastqc, multiqc for combining qc result
Using the provided tools:  
+ Bashscript
+ Fastqc
+ Multiqc
+ Download at least 3 files from: https://zenodo.org/record/3736457#.Y-uoY3UzbIU

```
# Install tools 
sudo apt-get install fastqc
pip install multiqc

# Download files using browser or wget or curl
mkdir -p fastqc_example
cd fastqc_example

wget https://zenodo.org/record/3736457/files/1_control_ITS2_2019_minq7.fastq
wget https://zenodo.org/record/3736457/files/1_control_psbA3_2019_minq7.fastq
wget https://zenodo.org/record/3736457/files/1_control_psbA3_A_2019_minq7.fastq

# Fastqc and multiqc
fastqc *.fastq
multiqc *.html
```

# 02. Note: This exercise is for studying only, not a research.
I have a sequences hat I sequenced using Download a set of DNA sequence files in FASTA format from a public database, such as NCBI, and write a bash script 
that uses the command-line tool grep to extract sequences that match a specific pattern with exact match. Using term "Homo sapiens[Organism] AND liver[All Fields]" with 
nucleotide database. The pattern is "GGTACCAGCT". Provide the first match and stop finding more.
Using the provided tools:  
+ Bash script  
+ Esearch: For searching the accession number related to query
+ Efetch: For downloading the fastq file 

```
#!/bin/bash

# Define the NCBI database and search term
db="nuccore"
search_term="Homo sapiens[Organism] AND liver[All Fields]"

# Use esearch to retrieve the list of matching accession numbers
esearch -db $db -query "$search_term" | efetch -format acc > accessions.txt

# Download the FASTA files for the matching accessions
while read accession; do
    efetch -db $db -id $accession -format fasta >> sequences.fasta
done < accessions.txt

# Extract sequences that match a specific pattern using grep
grep -A 1 "GGTACCAGCT" sequences.fasta > matched_sequences.fasta
```
