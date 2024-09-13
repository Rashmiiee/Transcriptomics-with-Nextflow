
process qualimap {
    input:
    path bam_file

    output:
    path "rnaseq_qc_results_${bam_file.name.take(11)}/*.html"

    publishDir '/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_qualimap', mode: 'copy'

    script:
    """
    /Applications/software_bioinformatics/qualimap_v2.3/qualimap rnaseq \
    -bam $bam_file \
    -gtf ${params.gtffile} \
    -outdir "rnaseq_qc_results_${bam_file.name.take(11)}"
    """
}