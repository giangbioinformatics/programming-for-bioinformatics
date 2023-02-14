Table of content:
- [1.Conda](#1conda)
  * [1.1 Install Miniconda:](#11-install-miniconda-)
  * [1.2 Create a conda environment:](#12-create-a-conda-environment-)
  * [1.3 Activate the environment:](#13-activate-the-environment-)
  * [1.4 Install fastqc package:](#14-install-fastqc-package-)
  * [1.5 Verify the installation:](#15-verify-the-installation-)
- [2.Docker](#2docker)
  * [2.1 Install Docker:](#21-install-docker-)
  * [2.2 Download the FastQC Docker image:](#22-download-the-fastqc-docker-image-)
  * [2.3 Run the FastQC Docker container:](#23-run-the-fastqc-docker-container-)
  * [2.4 View the FastQC report:](#24-view-the-fastqc-report-)
  * [2.5 How to build image container](#25-how-to-build-image-container)
- [3.Singularity](#3singularity)
  * [3.1 Install Singularity:](#31-install-singularity-)
  * [3.2 Create a fefinition File:](#32-create-a-fefinition-file-)
  * [3.3 Build image file from definition file](#33-build-image-file-from-definition-file)
  * [3.4 Run singularity image](#34-run-singularity-image)

# 1.Conda
Conda is a popular open-source package management system and environment management system that is commonly used in scientific computing and data science. With conda, you can create isolated environments that contain specific versions of packages and dependencies. This allows you to manage the dependencies of your software projects and ensure that you can reproduce your results. Conda makes it easy to install, manage, and update packages and libraries, and it works on Windows, macOS, and Linux. To create an isolated environment, you can use the conda create command, and to activate the environment, you can use the conda activate command.
Here is a tutorial for using conda to install and use the fastqc package:

## 1.1 Install Miniconda:
Miniconda is a minimal distribution of the Conda package manager. You can install Miniconda from the following website: https://docs.conda.io/en/latest/miniconda.html

## 1.2 Create a conda environment:
```
conda create --name fastqc_env
```
This will create an isolated environment named "fastqc_env".

## 1.3 Activate the environment:
```
conda activate fastqc_env
```
This will activate the fastqc_env environment so that any packages installed will be installed within this environment.

## 1.4 Install fastqc package:

```
conda install -c bioconda fastqc
```
## 1.5 Verify the installation:
```
fastqc -v
```
This should display the version of the fastqc package installed in the environment.
```
fastqc <input_file.fastq>
```
This will generate the FastQC report for the input fastq file.

Now you can use the fastqc package within the isolated environment, and it will not affect the packages installed in your base environment.

# 2.Docker
One popular containerization technology is Docker. To isolate an environment in Docker, you need to create a Dockerfile that specifies the dependencies and environment configurations required for your software. You can then build an image from the Dockerfile and run a container from the image.
Here is a simple tutorial on how to use Docker to run FastQC:

## 2.1 Install Docker:
Before using Docker, make sure that you have installed Docker on your machine. To install Docker, follow the instructions for your operating system: https://docs.docker.com/get-docker/

## 2.2 Download the FastQC Docker image:
FastQC is available as a Docker image on the Docker Hub. You can download the image using the following command:
```
docker pull biocontainers/fastqc:v0.11.8_cv2
```
## 2.3 Run the FastQC Docker container:
Once the Docker image is downloaded, you can run the FastQC Docker container using the following command:
```
docker run -v /path/to/fastq/files:/data biocontainers/fastqc:v0.11.8_cv2 fastqc /data/*.fastq
```
Replace "/path/to/fastq/files" with the path to your fastq files, and replace "*.fastq" with your fastq file names.

## 2.4 View the FastQC report:
The FastQC report will be generated in the current working directory. You can view the report by opening the HTML file in a web browser.
By using Docker, you can isolate the FastQC environment and ensure that it is running with the correct dependencies, versions, and configurations. This makes it easier to run FastQC on different operating systems, and ensures that the results are consistent and reproducible.

## 2.5 How to build image container
```
# Start from the base R image
FROM r-base

# Install required packages
RUN apt-get update \
    && apt-get install -y libxml2-dev libssl-dev libcurl4-openssl-dev \
    && R -e "install.packages(c('dplyr', 'tidyr', 'ggplot2', 'DESeq2'))"

# Set the working directory
WORKDIR /app

# Copy the pipeline script to the container
COPY pipeline.R .

# Run the pipeline script
CMD ["Rscript", "pipeline.R"]
```
# 3.Singularity
Singularity can be installed on various operating systems, including Linux, macOS, and Windows (WSL2). Here are the basic steps to install and build a Singularity image:

## 3.1 Install Singularity: 
To install Singularity on your system, you will need to follow the instructions for your specific operating system, which can be found on the Singularity website (https://singularity.lbl.gov/install-linux).

## 3.2 Create a fefinition File: 
A Singularity definition file is a text file that specifies the instructions for building a Singularity image. It includes information about the base image to use, packages to install, and any custom configurations.

Build the Image: To build the image, you can use the singularity build command followed by the name you want to give the image and the path to the definition file. For example:
```
Bootstrap: library
From: ubuntu:20.04

%post
    apt-get update
    apt-get install -y wget unzip
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
    unzip fastqc_v0.11.9.zip
    chmod 755 FastQC/fastqc
    ln -s $(pwd)/FastQC/fastqc /usr/local/bin/fastqc

%runscript
    fastqc "$@"
```
## 3.3 Build image file from definition file
Build with simple command
```
singularity build FastQC.sif FastQC.def
```
## 3.4 Run singularity image
```
singularity run FastQC.sif <input fastq file>
```
