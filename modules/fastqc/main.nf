
// Define parameters
//params.outdir = "results"
//params.reads = "raw_data/fastq/*.fastq"

//println "reads: $params.reads"

// Create a channel for single-end reads
//read_ch = Channel.fromPath(params.reads)
//.ifEmpty { error "Cannot find any reads: ${params.reads}" }

// Define the FastQC process
process fastqc {
    input:
    path reads
    tag "${reads.baseName}"

    output:
    path ("*_fastqc.html")
    path ("*_fastqc.zip")
    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_fastqc_1', mode: 'copy'

    script:
    """
    fastqc -t 6 ${reads}

    """
}

//${params.outdir}

// Define the workflow
//workflow {
    //Run FastQC
//    result_ch = fastqc(read_ch)
    
//}
