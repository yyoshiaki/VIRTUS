class: Workflow
cwlVersion: v1.0
id: virtect_cwl
label: VirTect_cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq2
    type: File
    'sbg:x': -510
    'sbg:y': -468
  - id: fastq1
    type: File
    'sbg:x': -522
    'sbg:y': -269
  - id: genomeDir_human
    type: Directory
    'sbg:x': -305
    'sbg:y': -602
  - id: outFileNamePrefix_human
    type: string?
    'sbg:x': -304
    'sbg:y': -750
  - id: nthreads
    type: int?
    'sbg:x': -319.9783020019531
    'sbg:y': 9.23515796661377
outputs:
  - id: Log.out
    outputSource:
      - star_mapping_pe_human/Log.out
    type: File?
    'sbg:x': 201
    'sbg:y': -114
  - id: Log.progress.out
    outputSource:
      - star_mapping_pe_human/Log.progress.out
    type: File?
    'sbg:x': 203
    'sbg:y': -268
  - id: SJ.out.tab
    outputSource:
      - star_mapping_pe_human/SJ.out.tab
    type: File?
    'sbg:x': 206
    'sbg:y': -425
  - id: aligned_bam_human
    outputSource:
      - star_mapping_pe_human/aligned
    type: File
    'sbg:x': 57.4921875
    'sbg:y': 130.5
  - id: unmapped_bam
    outputSource:
      - samtools_view/output
    type: stdout
    'sbg:x': 317
    'sbg:y': 33
steps:
  - id: fastp_pe
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
      - id: threads
        source: nthreads
    out:
      - id: out_fastq1
      - id: out_fastq2
    run: ../tool/fastp/fastp-pe.cwl
    'sbg:x': -302
    'sbg:y': -343
  - id: star_mapping_pe_human
    in:
      - id: fq1
        source: fastp_pe/out_fastq1
      - id: fq2
        source: fastp_pe/out_fastq2
      - id: genomeDir
        source: genomeDir_human
      - id: nthreads
        source: nthreads
      - id: outSAMunmapped
        default: Within
      - id: outFileNamePrefix
        source: outFileNamePrefix_human
      - id: outSAMtype
        default: BAM SortedByCoordinate
    out:
      - id: aligned
      - id: bamRemDups
      - id: mappingstats
      - id: readspergene
      - id: transcriptomesam
      - id: Log.out
      - id: Log.progress.out
      - id: SJ.out.tab
      - id: unmapped
    run: ../tool/star/star_mapping-pe/star_mapping-pe.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': -29
    'sbg:y': -369
  - id: samtools_view
    in:
      - id: threads
        source: nthreads
      - id: bam
        source: star_mapping_pe_human/aligned
    out:
      - id: output
    run: ../tool/samtools/samtools-view.cwl
    label: samtools-view
    'sbg:x': 155
    'sbg:y': 33
requirements: []
