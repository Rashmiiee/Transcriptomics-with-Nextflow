//params.reads = "results/results_trimmomatic/*_{1,2}.fastq.gz"  // Path to input files
//params.outputDir = "results/results_fastp"  // Path to output directory

// Print input reads for verification
//println "reads: $params.reads"

// Create a channel for paired-end reads
//read_pairs_ch = Channel.fromFilePairs(params.reads)
//    .ifEmpty { error "Cannot find any reads: ${params.reads}" }
//    .map { pair -> pair[1] }  // Extract only the list of file paths
//    .view()

// Define the fastp process
process fastp {
    input:
    tuple path(read1), path(read2)

    output:
    tuple path("${read1.name.take(11)}_trimmomatic_fastp_1.fastq.gz"), 
          path("${read2.name.take(11)}_trimmomatic_fastp_2.fastq.gz")

    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_fastp', mode: 'copy'

    script:
    """
    fastp -i ${read1} -I ${read2} -o ${read1.name.take(11)}_trimmomatic_fastp_1.fastq.gz -O ${read2.name.take(11)}_trimmomatic_fastp_2.fastq.gz --trim_tail1 3 --trim_tail2 3
    """
}

// Define the workflow
//workflow {
//    fastp(read_pairs_ch)
//}
