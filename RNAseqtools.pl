#! /usr/bin/perl
use strict;
use warnings;
my $hista2 = "/data/00/software/hisat/hisat2-2.1.0/hisat2";
my $hista2build = "/data/00/software/hisat/hisat2-2.1.0/hisat2-build";
my $samtools = "/data/00/software/samtools/samtools-1.15.1/samtools";
my $fastp = "/data/00/software/fastp/fastp_20190417/fastp";
my $stringtie = "/data/01/user214/cishu/SRArna/stringtie-2.2.1.Linux_x86_64/stringtie";
my $prepDE = "/data/01/user214/cishu/SRArna/stringtie-2.2.1.Linux_x86_64/prepDE.py";
my $ref = shift or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation"; 
my $samplelist = shift or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
my $gtf = shift or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
system "mkdir sam ; mkdir bam; mkdir output";
open O1, "> 1.hista2build.sh " or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
print O1 "$hista2build -p 4 $ref ref";
print STDERR ".....1.hista2build.sh.....has created\n";
open O2, ">2.fastp.sh" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
open O3, ">3.hista2.sh" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
open O4, ">4.samtools.sh" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
open O5, ">5.stringtie.sh" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
open O6, ">6.prepDE.sh" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
open I, "<$samplelist" or die "Usage : ./RNAseqtools Reference_Genome Samplelist Gtf_annotation";
while (<I>)
{
	chomp;
	my @line = split(/\t/);
	##fastp
	print O2 "$fastp -l 45 -q 20 -w 15 -i $line[0] -I $line[1] -o $line[2]_clean_1.fq.gz -O $line[2]_clean_2.fq.gz\n";
	##hista2 align
	print O3 "$hista2 -x ref -p 8 -1 $line[2]_clean_1.fq.gz -2 $line[2]_clean_2.fq.gz  -S sam/$line[2].sam\n";
	##samtools
	print O4 "$samtools view -@ 16 -b -S sam/$line[2].sam -o sam/$line[2].bam && $samtools sort ./sam/$line[2].bam > ./bam/$line[2].sort.bam \n";
	##stringtie
	print O5 "$stringtie -G $gtf -o ./output/$line[2]/$line[2].gtf -e -B  -A ./output/$line[2]/$line[2].gene.tab bam/$line[2].sort.bam\n";
}
print O6 "cd output ; $prepDE ./ \n";
print STDERR ".....2.fastp.sh.....has created\n";
print STDERR ".....3.hista2.sh.....has created\n";
print STDERR ".....4.samtools.sh.....has created\n";
print STDERR ".....5.stringtie.sh.....has created\n";
print STDERR ".....6.prepDE.sh.....has created\n";
