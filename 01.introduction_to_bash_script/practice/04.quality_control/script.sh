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