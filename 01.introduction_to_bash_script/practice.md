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
```
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
```
# 08. Making whole genome for bateria using spades
```
fastq-dump --split-files SRR1234567
trimmomatic PE -phred33 SRR1234567_1.fastq SRR1234567_2.fastq SRR1234567_1.trimmed.fastq SRR1234567_1.unpaired.fastq SRR1234567_2.trimmed.fastq SRR1234567_2.unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
spades.py -1 SRR1234567_1.trimmed.fastq -2 SRR1234567_2.trimmed.fastq -o spades_output
```
# 09. Evaluate the genome complete or not complete
There are a few metrics commonly used to assess the completeness of a bacterial genome assembly:

Genome size: The genome size of the assembly should be consistent with the expected size for the organism.

N50 and L50 values: These values give an indication of the contiguity of the assembly. The N50 value is the length of the shortest contig such that 50% of the genome is contained in contigs of that length or longer. The L50 value is the number of contigs required to cover 50% of the genome. Higher N50 and lower L50 values are generally indicative of a more contiguous assembly.

Completeness and redundancy: The completeness of the assembly can be assessed using tools like CheckM or BUSCO, which compare the assembly to a set of conserved genes that are expected to be present in all bacterial genomes. These tools can also estimate the level of redundancy in the assembly, which can be an indicator of misassemblies or other errors.

Gene prediction: The quality of the gene predictions can also be used as a proxy for the completeness of the assembly. Tools like Prokka or RAST can be used to annotate the assembly and predict the protein-coding genes. A more complete assembly should have a higher proportion of genes with functional annotations and fewer hypothetical or unknown genes.

It's important to note that no assembly is perfect, and different metrics may be more important for different applications. For example, a highly contiguous assembly may be more important for genome annotation, while a more complete assembly may be required for comparative genomics.

Definition of L50
! Let's consider an example where we have a genome assembly with a total size of 10,000 base pairs (bp) and the assembly consists of 10 contigs with the following lengths (in bp):

1000, 800, 700, 600, 500, 400, 300, 200, 100, 100

To calculate the L50, we would first arrange the contigs in decreasing order of length and then add up the lengths of the contigs one by one, starting with the longest. The L50 is the minimum number of contigs required to reach 50% of the total assembly size. In this example, the calculation would be as follows:

Arrange contigs in decreasing order of length:
1000, 800, 700, 600, 500, 400, 300, 200, 100, 100

Add up the lengths of the contigs one by one:
1000 + 800 + 700 + 600 + 500 = 3600

The L50 is the minimum number of contigs required to reach 50% of the total assembly size, which is 5000 bp in this case. In other words, we count the number of contigs required to reach a cumulative length that is greater than or equal to half of the total assembly size. In this example, the L50 would be 5, since the first 5 contigs (1000, 800, 700, 600, and 500) have a total length of 3600 bp, which is greater than or equal to 50% of the total assembly size.

Definition of N50
The N50 is a statistic used to describe the contiguity of a genome assembly, and it is defined as the length of the shortest contig (or scaffold) that covers 50% of the total assembly length.

To calculate the N50, you first need to order the contigs (or scaffolds) in descending order of length. Then, you add up the lengths of the contigs (or scaffolds) from longest to shortest, until the sum of their lengths reaches 50% of the total assembly length. The length of the last contig (or scaffold) that you added to reach the 50% mark is the N50.

For example, suppose you have an assembly with 10 contigs of lengths 1000, 800, 700, 600, 500, 400, 300, 200, 100, and 50 base pairs. The total assembly length is 4050 base pairs. To calculate the N50, you first order the contigs by length:
```
1000
1800 (1000 + 800)
2500 (1000 + 800 + 700)
3100 (1000 + 800 + 700 + 600)
3600 (1000 + 800 + 700 + 600 + 500)
4000 (1000 + 800 + 700 + 600 + 500 + 400)
```
```
#!/bin/bash

# Run CheckM on the SPAdes assembly
checkm lineage_wf -t 4 -x fa spades_assembly/ checkm_output/

# Print the completeness and contamination estimates
cat checkm_output/storage/bin_stats_ext.tsv
```
In this script, checkm lineage_wf runs the CheckM workflow on the SPAdes assembly. The -t 4 option specifies that CheckM should use four threads for parallel processing, and the -x fa option specifies that the input files are in FASTA format. spades_assembly/ is the path to the directory containing the SPAdes assembly files, and checkm_output/ is the directory where CheckM output files will be written.

After running CheckM, you can view the completeness and contamination estimates by printing the bin_stats_ext.tsv file in the checkm_output/storage directory. The completeness estimate is listed under the Completeness column, and the contamination estimate is listed under the Contamination column.
# 10. Give the annotation for genome
```
```
