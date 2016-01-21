#!/bin/csh
#PBS -q hotel
#PBS -N tf_binding
#PBS -l nodes=1:ppn=3
#PBS -l walltime=0:10:00
#PBS -o tf_binding_output_file.o
#PBS -e tf_binding_error_file.e
#PBS -V
#PBS -M bvtsu@ucsd.edu
#PBS -m abe

cd ~/code/biom262-2016/weeks/week01/data
%%bash --out exercise1
# YOUR CODE HERE
grep 'NFKB' tf.bed > tf.nfkb.bed
wc -l tf.nfkb.bed
echo '--- First 10 lines ---'
head tf.nfkb.bed
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}'  tf.nfkb.bed | head
echo '--- Last 10 lines ---'
tail tf.nfkb.bed
print(exercise1)
%%bash --out exercise2
# YOUR CODE HERE
cat gencode.v19.annotation.chr22.gtf | awk '$3 ~ /transcript/ {print}' > gencode.v19.annotation.chr22.transcript.gtf
wc -l gencode.v19.annotation.chr22.transcript.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print $0}' gencode.v19.annotation.chr22.transcript.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.gtf
print(exercise2)
%%bash --out exercise3
# YOUR CODE HERE
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome  -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf
wc -l gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{print rand()" "$0}' gencode.v19.annotation.chr22.transcript.promoter.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.gtf
print(exercise3)




%%bash --out exercise4
# Hi, this is my code for exercise4. Brian.
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

print(exercise4)

%%bash --out exercise5

# Hi, here is my code. Sincerely, Brian.
module load biotools
bedtools getfasta -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta -s

wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

print(exercise5)

%%bash --out exercise6
#downloaded file with 8000+ canonical nfkb binding sites
#pasted column one (forward strand 11-mer binding sites) into canonical_seqs_nfkb_plus.txt
#pasted column two (rev strand 11-mer binding sites) into canonical_seqs_nfkb_minus.txt
#My code here for matching forward strand binding sites, just searching for "+" and printing next line, then searching through the canonical_seqs_nfkb_plus.txt list for matches:
awk '/+/{getline;print}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | grep -Ff canonical_seqs_nfkb_plus.txt | wc -l
#My code here for matching reverse strand binding sites, because there exists a "-" between the nuc positions, I must specify that I am looking for a "-" next to am open parenthesis "(". Then print next line, and searching through the canonical_seqs_nfkb_minus.txt list for matches
awk '/\(-/{getline;print}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | grep -Ff canonical_seqs_nfkb_minus.txt | wc -l

print(exercise6)

#YOUR ANSWER HERE: 297 forward 11-mer matches +216 rev complemented 11-mers
# = 513

echo "Hello I am a message in standard out (stdout)"
echo "Hello I am a message in standard error (stderr) >&2"
