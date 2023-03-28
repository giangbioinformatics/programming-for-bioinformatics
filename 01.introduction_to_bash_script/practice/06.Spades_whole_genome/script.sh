fastq-dump --split-files SRR1234567
trimmomatic PE -phred33 SRR1234567_1.fastq SRR1234567_2.fastq SRR1234567_1.trimmed.fastq SRR1234567_1.unpaired.fastq SRR1234567_2.trimmed.fastq SRR1234567_2.unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
spades.py -1 SRR1234567_1.trimmed.fastq -2 SRR1234567_2.trimmed.fastq -o spades_output