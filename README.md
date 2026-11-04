# bowtie2_ARGreads_count

The obtained sam files from bowtie2 analysis, were filtered by an in-house ruby script read_counts_v4.rb, which removes the gene over-estimation occurring when forward and reverse reads are aligned with the same gene:

ruby read_counts.rb sam_files_folder

To run correctly this script, you need to download phenotypes.txt file from https://bitbucket.org/genomicepidemiology/resfinder_db/src/master/phenotypes.txt, by:

    wget https://bitbucket.org/genomicepidemiology/resfinder_db/src/master/phenotypes.txt
    
And run the script by:

    ruby count_reads.rb sam_files_folder/
