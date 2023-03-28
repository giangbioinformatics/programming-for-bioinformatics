# Install SRA tools kit
wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
# Unzip
tar -vxzf sratoolkit.tar.gz
# Better with add to bashrc
export PATH=$PATH:$PWD/sratoolkit.3.0.1-ubuntu64/bin
# Check tools exist
which fastq-dump
fastq-dump --help

# Download file
SRA_ACCESSIONS="SRR123456 SRR789012 SRR345678"
# Set the output directory for the FASTQC reports
OUTPUT_DIR="fastqc_reports"

# Create the output directory if it doesn't already exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir "$OUTPUT_DIR"
fi

# Define an array of SRA accession numbers for the RNA-seq data files
ACCESSIONS=(SRR23502807 	SRR23502808	 SRR23502809)

# Loop over each accession number and download the corresponding FASTQ file
for ACCESSION in "${ACCESSIONS[@]}"; do
  echo "Downloading FASTQ file for $ACCESSION"
  fastq-dump --outdir . --gzip --skip-technical --readids --dumpbase --split-3 --clip "$ACCESSION"
  
  # Run FASTQC on the downloaded FASTQ file and save the report to the output directory
  echo "Running FASTQC for $ACCESSION"
  fastqc --outdir "$OUTPUT_DIR" "${ACCESSION}.fastq.gz"
done

###################################################################################################
# Update script for md5 check, redownload until they are matched
#!/bin/bash
# Set the SRA accessions for the RNA-seq data files
SRA_ACCESSIONS="SRR123456  SRR789012  SRR345678"

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