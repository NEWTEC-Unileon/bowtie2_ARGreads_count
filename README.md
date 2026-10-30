# bowtie2_ARGreads_count

The obtained sam files from bowtie2 analysis, were filtered by an in-house ruby script read_counts_v4.rb, which removes the gene over-estimation occurring when forward and reverse reads are aligned with the same gene:

ruby read_counts.rb sam_files_folder

To run correctly this script, you need to build previously the gene_list.txt file (in our case, a modified version of Supplementary Table 2, removing first column and reordering the other columns), with contains 4 columns:

    Family: antibiotic family to which the ARG confer resistance to

    Genefam: gene family build by CD-HIT alignment at 90% identity of ARG from ResFinder (and manually inspected to give the name according to the most abundant gene within each cluster or by the first number of the cluster within bla and addA genes)

    Gene: gene name, removing everything after "_" from the hit

    Hit: hit or gene name according to ResFinder database

To obtain the Family, Gene and Hit columns information, we recommend to download the phenotypes.txt and all.fsa files from ResFinder (https://bitbucket.org/genomicepidemiology/resfinder_db/src/master/), to run CD-HIT and following script:

cdhit -i all.fsa -o cdhit.txt -c 0.9
ruby extract_cluster_table.rb

You must curate (and add) the genefam column manually according to cluster and gene columns resulted.
