# Install tools
sudo apt install cutadapt
# Download RNA-seq data from SRA (limit to 10 MB)
fastq-dump --outdir fastq --gzip --skip-technical --readids --dumpbase --split-3 --clip --bytes 10000000 SRR5222442
# Trim adapters using cutadapt
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o trimmed.fastq.gz fastq/SRR5222442.fastq.gz
# Remove intermediate files
rm -r fastq
