process trimmomatic {
    input:
    tuple path(read1), path(read2)

    output:
    tuple path("${read1.name.take(11)}_cutadapt_trimmomatic_1.fastq.gz"), 
           //path("${read1.baseName}_forward_unpaired.fastq.gz"), 
           path("${read2.name.take(11)}_cutadapt_trimmomatic_2.fastq.gz") 
           //path("${read2.baseName}_reverse_unpaired.fastq.gz")

    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_trimmomatic', mode: 'copy'

    script:
    """
    java -jar /Applications/software_bioinformatics/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 4 \
    ${read1} ${read2} \
    ${read1.name.take(11)}_cutadapt_trimmomatic_1.fastq.gz ${read1.baseName}_forward_unpaired.fastq.gz \
    ${read2.name.take(11)}_cutadapt_trimmomatic_2.fastq.gz ${read2.baseName}_reverse_unpaired.fastq.gz \
    ILLUMINACLIP:${params.adapfile}:2:30:5:2 \
    HEADCROP:12 SLIDINGWINDOW:5:20 MINLEN:35
    """
}