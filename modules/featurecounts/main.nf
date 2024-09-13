params.bam_dir = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_star"
params.annotation_file = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/yeast.gtf"

bam_dir_ch = Channel.fromPath(params.bam_dir)
    .ifEmpty { error "Cannot find the BAM directory: ${params.bam_dir}" }
    .view()

process featurecounts {
    input:
    path bam_dir_ch

    output:
    path "FeatureCounts.txt"
    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_featurecounts', mode: 'copy'
    
    script:
    """
    bam_files=\$(ls ${bam_dir_ch}/*.bam)

    /Applications/software_bioinformatics/subread-2.0.2-macOS-x86_64/bin/featureCounts \\
        -T 8 -p -a ${params.annotation_file} \\
        -o FeatureCounts.txt \$bam_files
    """
}

workflow {
    featurecounts(bam_dir_ch)
}
