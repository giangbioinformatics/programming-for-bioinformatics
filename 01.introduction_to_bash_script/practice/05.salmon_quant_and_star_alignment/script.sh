#!/bin/bash

# Set the NCBI accession number for the genome assembly and the SRA accession number for the RNA-seq reads
GENOME_ACCESSION="GCF_000001405.26"
READS_ACCESSION="SRR3051647"

# Download the genome assembly file in FASTA format
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/$GENOME_ACCESSION/$GENOME_ACCESSION_genomic.fna.gz"
gunzip "$GENOME_ACCESSION_genomic.fna.gz"

# Download the RNA-seq reads in FASTQ format using the SRA toolkit
fastq-dump "$READS_ACCESSION"

# Build a genome index for STAR
STAR --runMode genomeGenerate --genomeDir star_index --genomeFastaFiles "$GENOME_ACCESSION_genomic.fna" --runThreadN 4

# Align the RNA-seq reads to the genome using STAR
STAR --genomeDir star_index --readFilesIn "$READS_ACCESSION.fastq" --runThreadN 4 --outSAMtype BAM SortedByCoordinate --outFileNamePrefix aligned

# Index the BAM file
samtools index aligned.bam