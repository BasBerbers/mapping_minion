#!/bin/bash
# a simple mapping script for minion reads with bwa mem

# by editing script define files that are going to be used

FASTA= /fullpath/to/file1.fasta
FASTQ= /fullpath/to/file2.fastq

# index the fasta file

# bwa index $FASTA

# mapping,-x ont2d allows for mapping with reads that have a high error rate (not as precise as with other reads)

# bwa mem -x ont2d -t 24 $FASTA $FASTQ > aln.sam
minimap2 -ax map-ont $FASTA $FASTQ > aln.sam

# convert sam file to bam

samtools view -S aln.sam -b -o aln.bam -@ 24

# sort the bam file

samtools sort aln.bam -o aln.sorted.bam -@ 24

# index the bam file

samtools index aln.sorted.bam aln.sorted.bai -@ 24

# aln.sorted.bam and aln.sorted.bai should be used to visualize mapping on IGV
# example --> java -jar /fullpath/to/igv.jar
