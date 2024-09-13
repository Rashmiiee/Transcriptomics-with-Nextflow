// Define parameters
//params.reads2 = "raw_data/fastq/SRR*_{1,2}.fastq.gz"
//params.file = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/fastq/adapters.fa"

//println "reads: $params.reads2"

// Create a channel for paired-end reads
//read_pairs_ch = Channel.fromFilePairs(params.reads2)
//    .ifEmpty { error "Cannot find any reads: ${params.reads2}" }
//    .map { pair -> pair[1] }  // Extract only the list of file paths
//    .view()

// Define the Cutadapt process
process cutadapt {
    input:
    tuple path(read1), path(read2)

    output:
    tuple path("SRR????????_fastqc_cutadapt_1.fastq.gz"), path("SRR????????_fastqc_cutadapt_2.fastq.gz"), emit: processed_files_ch
    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_cutadapt', mode: 'copy'

    script:
    """
    echo "Read 1 Path: ${read1}"
    echo "Read 2 Path: ${read2}"
    
    cutadapt \
    -a file:${params.adapfile} \
    -A file:${params.adapfile} \
    -o ${read1.baseName}_cutadapt_1.fastq.gz \
    -p ${read2.baseName}_cutadapt_2.fastq.gz \
    ${read1} \
    ${read2} \
    > cutadapt.log

    echo "Cutadapt process completed."
    bash /Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_cutadapt/change_names.sh
    echo "Files have been renamed"
    """
}


// Define the workflow
//workflow {
//    // Run Cutadapt
//    cutadapt(read_pairs_ch)
//}
