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
# 04.Cutadapt:
Write a bash script that uses the command-line tool cutadapt to trim adapter sequences from a set of Illumina RNA-seq data files in FASTQ format.
Using prevous id, dont need to check md5. Get the ideas, then, when you work on your real cases, just remember to do it.
```
#!/bin/bash

# Set the SRA accessions for the RNA-seq data files
SRA_ACCESSIONS="SRR123456 SRR789012 SRR345678"

# Loop through each SRA accession and download the FASTQ file
for ACCESSION in $SRA_ACCESSIONS; do
  fastq-dump --outdir . --gzip --skip-technical --readids --dumpbase --split-3 --clip "$ACCESSION"
done

# Set the adapter sequence
ADAPTER="AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC"

# Loop through each downloaded FASTQ file and trim adapter sequences
for FILE in *.fastq.gz; do
  # Trim the adapter sequences using cutadapt
  cutadapt -a "$ADAPTER" -o "${FILE%%.*}.trimmed.fastq.gz" "$FILE"

  # Remove the original FASTQ file
  rm "$FILE"
done
```
# 05. Homologous protein domain
Download a set of protein sequence files in FASTA format from a public database, such as UniProt, and write a bash script that uses the command-line tool hmmscan to search for homologous protein domains.
```
#!/bin/bash

# Set the UniProt accessions for the protein sequences
UNIPROT_ACCESSIONS="P12345 P67890 Q98765"

# Loop through each UniProt accession and download the corresponding FASTA file
for ACCESSION in $UNIPROT_ACCESSIONS; do
  wget -O "${ACCESSION}.fasta" "https://www.uniprot.org/uniprot/${ACCESSION}.fasta"
done

# Download the Pfam database
wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam33.0/Pfam-A.hmm.gz
gunzip Pfam-A.hmm.gz

# Run hmmscan on each protein sequence file and output the results to a text file
for FILE in *.fasta; do
  # Run hmmscan on the protein sequence file using the Pfam-A database
  hmmscan --tblout "${FILE%%.*}.txt" Pfam-A.hmm "$FILE"

  # Print the results to the screen
  echo "Results for ${FILE}:"
  cat "${FILE%%.*}.txt"
done
```

# 06. Bedtools:
Write a bash script that uses the command-line tool bedtools to intersect two sets of genomic intervals, such as ChIP-seq peaks and gene promoters.
Move to NCBI search for bed file to test the script below.
```
#!/bin/bash

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
# 07. Samtools:
Download a set of genome assembly files in FASTA format from a public database, such as the NCBI Genome database, and write a bash script that uses the command-line tool samtools to align RNA-seq reads to the genome and generate a BAM file.
# 08. Making whole genome for bateria

# 09. Evaluate the genome complete or not complete

# 10. Give the annotation for genome
