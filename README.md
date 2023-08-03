# RNAseqtools

#  1.Create List

    ll | awk '{print $9}' | grep  '1.fastq.gz' > ../left.txt 
    ll | awk '{print $9}' | grep  '2.fastq.gz' > ../right.txt
    paste -d '\t'   left.txt right.txt > all.txt

And modify the all.txt by hand, the final format is 

        #fastq1  #fastq2  #name

        SRR17999603_1.fastq.gz  SRR17999603_2.fastq.gz  gy1blood

        SRR17999604_1.fastq.gz  SRR17999604_2.fastq.gz  gy2blood

        SRR17999605_1.fastq.gz  SRR17999605_2.fastq.gz  gy3blood

        SRR17999606_1.fastq.gz  SRR17999606_2.fastq.gz  gy4blood

        SRR17999607_1.fastq.gz  SRR17999607_2.fastq.gz  gy5blood

        SRR17999608_1.fastq.gz  SRR17999608_2.fastq.gz  gy6blood

        SRR5621564_1.fastq.gz   SRR5621564_2.fastq.gz   dwe1blood

        SRR5621574_1.fastq.gz   SRR5621574_2.fastq.gz   dwe2blood

#    2.Run software

         ./RNAseqtools Reference_Genome Samplelist Gtf_annotation
        or perl RNAseqtools.pl Reference_Genome Samplelist Gtf_annotation

if success, will print :

        .....1.hista2build.sh.....has created
        .....2.fastp.sh.....has created
        .....3.hista2.sh.....has created
        .....4.samtools.sh.....has created
        .....5.stringtie.sh.....has created
        .....6.prepDE.sh.....has created

then run by order will success.
