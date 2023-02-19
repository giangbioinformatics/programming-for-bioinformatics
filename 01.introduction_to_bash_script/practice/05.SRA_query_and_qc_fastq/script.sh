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