params.reads = "results/results_cutadapt/*_{1,2}.fastq.gz"
params.file = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/fastq/adapters.fa"

println "reads: $params.reads"

// Create a channel for paired-end reads
read_pairs_ch = Channel.fromFilePairs(params.reads)
    .ifEmpty { error "Cannot find any reads: ${params.reads}" }
    .map { pair -> pair[1] }  // Extract only the list of file paths
    .view()

process trimmomatic2 {
    input:
    tuple path(read1), path(read2)

    output:
    tuple path("${read1.name.take(11)}_cutadapt_trimmomatic_1.fastq.gz"), 
           path("${read1.baseName}_forward_unpaired.fastq.gz"), 
           path("${read2.name.take(11)}_cutadapt_trimmomatic_2.fastq.gz"), 
           path("${read2.baseName}_reverse_unpaired.fastq.gz")

    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_trimmomatic', mode: 'copy'

    script:
    """
    java -jar /Applications/software_bioinformatics/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 4 \
    ${read1} ${read2} \
    ${read1.name.take(11)}_cutadapt_trimmomatic_1.fastq.gz ${read1.baseName}_forward_unpaired.fastq.gz \
    ${read2.name.take(11)}_cutadapt_trimmomatic_2.fastq.gz ${read2.baseName}_reverse_unpaired.fastq.gz \
    ILLUMINACLIP:${params.file}:2:30:5:2 \
    HEADCROP:12 SLIDINGWINDOW:5:20 MINLEN:35
    """
}

workflow {
    trimmed_files_ch = trimmomatic2(read_pairs_ch)
    trimmed_files_ch.view()  // Add view to check contents
}
