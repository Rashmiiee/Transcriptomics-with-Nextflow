for file in SRR*_*.fastq_cutadapt_*.fastq.gz; do
  
  # Construct the new filename
  new_name=$(echo "$file" | sed 's/\(_\)[^_]*_/\1fastqc_/')
  
  # Rename the file
  mv "$file" "$new_name"
done
