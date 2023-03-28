# Install search
sh -c "$(wget -q ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"
# Add to barchrc
echo "export PATH=\$PATH:\$HOME/edirect" >> $HOME/.bash_profile
# Export to load tool immediately
export PATH=${PATH}:${HOME}/edirect

# Define the NCBI database and search term
db="nuccore"
search_term="Homo sapiens[Organism] AND liver[All Fields]"
# Use esearch to retrieve the list of matching accession numbers
esearch -db $db -query "$search_term" |head| efetch -format acc > accessions.txt

# Download the FASTA files for the matching accessions
while read accession; do
    efetch -db $db -id $accession -format fasta >> sequences.fasta
done < accessions.txt

# Extract sequences that match a specific pattern using grep
grep -A 1 "GTGGTGCGACATTTAGGGAAGGCAGAAAGTAG" sequences.fasta > matched_sequences.fasta