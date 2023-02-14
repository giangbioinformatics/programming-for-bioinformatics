# 01. QC fastq file
Download fastq file and make the quality control using fastqc, multiqc for combining qc result
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
Note: Should check md5 check sum for making sure that the file is fully donwload.
md5sum <file_name>
```
md5sum 1_control_ITS2_2019_minq7.fastq
```

# 02. Searching pattern: 
This exercise is for studying only, not a research.
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
# 03. NCBI SRA download fastq and check quality 
Download a set of RNA-seq data files in FASTQ format from a public database, such as the Sequence Read Archive (SRA), and write a bash script that uses the command-line tool fastqc to assess the quality of the reads 
accession are 
```
SRA_ACCESSIONS="SRR123456 SRR789012 SRR345678"
```

```
#!/bin/bash

# Set the output directory for the FASTQC reports
OUTPUT_DIR="fastqc_reports"

# Create the output directory if it doesn't already exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir "$OUTPUT_DIR"
fi

# Define an array of SRA accession numbers for the RNA-seq data files
ACCESSIONS=(SRR1139775 SRR1139776 SRR1139777)

# Loop over each accession number and download the corresponding FASTQ file
for ACCESSION in "${ACCESSIONS[@]}"; do
  echo "Downloading FASTQ file for $ACCESSION"
  fastq-dump --outdir . --gzip --skip-technical --readids --dumpbase --split-3 --clip "$ACCESSION"
  
  # Run FASTQC on the downloaded FASTQ file and save the report to the output directory
  echo "Running FASTQC for $ACCESSION"
  fastqc --outdir "$OUTPUT_DIR" "${ACCESSION}.fastq.gz"
done
```
Update script for md5 check, redownload until they are matched
```
#!/bin/bash

# Set the SRA accessions for the RNA-seq data files
SRA_ACCESSIONS="SRR123456 SRR789012 SRR345678"

# Loop through each SRA accession and download the FASTQ file
for ACCESSION in $SRA_ACCESSIONS; do
  # Download the FASTQ file
  fastq-dump --outdir . --gzip --skip-technical --readids --dumpbase --split-3 --clip "$ACCESSION"

  # Set the expected MD5 checksum and output file name
  EXPECTED_MD5=$(cat "${ACCESSION}.fastq.gz.md5" | cut -d' ' -f1)
  OUTPUT_FILE="${ACCESSION}.fastq.gz"

  # Download the file and check the MD5 checksum
  while true; do
    # Download the file and calculate the MD5 checksum
    wget -q "https://example.com/$OUTPUT_FILE" -O "$OUTPUT_FILE"
    CALCULATED_MD5=$(md5sum "$OUTPUT_FILE" | cut -d' ' -f1)

    # Compare the calculated checksum to the expected checksum
    if [ "$CALCULATED_MD5" != "$EXPECTED_MD5" ]; then
      echo "Error: MD5 checksum does not match for $OUTPUT_FILE, re-downloading file"
      rm "$OUTPUT_FILE"
    else
      echo "MD5 checksum matches for $OUTPUT_FILE, file is valid"
      break
    fi
  done
done
```
