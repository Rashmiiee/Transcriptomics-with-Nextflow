//params.reads = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_fastp/*_[12].fastq.gz"
//params.genome_dir = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/ref_genome_files/index"
//params.gtffile = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/yeast.gtf"
//params.out_prefix ="out"
//params.threads = 4

//read_pairs_ch = Channel.fromFilePairs(params.reads)
//    .ifEmpty { error "Cannot find any reads: ${params.reads}" }
//    .map { pair -> pair[1] }  // Extract only the list of file paths
//    .view()

process star{
    input:
    tuple path(read1), path(read2)

    output:
    path("${read1.name.take(11)}Aligned.sortedByCoord.out.bam")
    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_star', mode: 'copy'

    script:
    """
    /Applications/software_bioinformatics/STAR/bin/MacOSX_x86_64/STAR --genomeDir "${params.genome_dir}" --readFilesCommand gunzip -c --readFilesIn "${read1}" "${read2}" --sjdbGTFfile "${params.gtffile}" --outFileNamePrefix "${read1.name.take(11)}" --runThreadN ${params.threads} --outSAMtype BAM SortedByCoordinate
    """
}

//workflow {
    // Run star
//    star(read_pairs_ch)
//}
