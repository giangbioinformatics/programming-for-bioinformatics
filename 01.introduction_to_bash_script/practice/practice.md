# 01. Searching pattern: 
E-tools that provided 
https://dataguide.nlm.nih.gov/eutilities/utilities.html

This exercise is for studying only, not a research.
I have a sequences hat I sequenced using Download a set of DNA sequence files in FASTA format from a public database, such as NCBI, and write a bash script 
that uses the command-line tool grep to extract sequences that match a specific pattern with exact match. Using term "Homo sapiens[Organism] AND liver[All Fields]" with 
nucleotide database. The pattern is "GGTACCAGCT". Provide the first match and stop finding more.
Using the provided tools:  
+ Bash script  
+ Esearch: For searching the accession number related to query
+ Efetch: For downloading the fastq file 

# 02. Bedtools:
Write a bash script that uses the command-line tool bedtools to intersect two sets of genomic intervals, such as ChIP-seq peaks and gene promoters.
Move to NCBI search for bed file to test the script below.

# 03. Homologous protein domain
Download a set of protein sequence files in FASTA format from a public database, such as UniProt, and write a bash script that uses the command-line tool hmmscan to search for homologous protein domains.

# 04. Quality control
Download fastq file and make the quality control using fastqc, multiqc for combining qc result
Using the provided tools:  
+ Bashscript
+ Fastqc
+ Multiqc
+ Download at least 3 files from: https://zenodo.org/record/3736457#.Y-uoY3UzbIU
# 05. NCBI SRA download fastq and check quality 
Download a set of RNA-seq data files in FASTQ format from a public database, such as the Sequence Read Archive (SRA), and write a bash script that uses the command-line tool fastqc to assess the quality of the reads 
accession are defined as below:  
SRA_ACCESSIONS="SRR23502807 	SRR23502808	 SRR23502809"
# 06.Cutadapt,trimmomatic and fastp:
Write a bash script that uses the command-line tool cutadapt to trim adapter sequences from a set of Illumina RNA-seq data files in FASTQ format. trimmomatic to trim quality and fastp for all of these tasks.

# 07. Samtools:
Download a set of genome assembly files in FASTA format from a public database, such as the NCBI Genome database, and write a bash script that uses the command-line tool samtools to align RNA-seq reads to the genome and generate a BAM file.

# 08. Making whole genome for bateria using spades
Using the fastq files from Illumina platform (short reads), de novo assembly and then evaluate the genome on later steps.
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
In this script, checkm lineage_wf runs the CheckM workflow on the SPAdes assembly. The -t 4 option specifies that CheckM should use four threads for parallel processing, and the -x fa option specifies that the input files are in FASTA format. spades_assembly/ is the path to the directory containing the SPAdes assembly files, and checkm_output/ is the directory where CheckM output files will be written.

After running CheckM, you can view the completeness and contamination estimates by printing the bin_stats_ext.tsv file in the checkm_output/storage directory. The completeness estimate is listed under the Completeness column, and the contamination estimate is listed under the Contamination column.
# 10. Give the annotation for genome
Base on the sequence of de novo genome, predict the existed genes and give their annotation.
