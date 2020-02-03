class: Workflow
cwlVersion: v1.0
id: virtect_cwl
label: VirTect_cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq2
    type: File
    'sbg:x': -532.9534301757812
    'sbg:y': -424.9623107910156
  - id: fastq1
    type: File
    'sbg:x': -534.9113159179688
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
    'sbg:x': -366.3414611816406
    'sbg:y': 303.09088134765625
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 670.920166015625
    'sbg:y': -69.70066833496094
outputs:
  - id: Log.out_human
    outputSource:
      - star_mapping_pe_human/Log.out
    type: File?
    'sbg:x': 201
    'sbg:y': -114
  - id: Log.progress.out_human
    outputSource:
      - star_mapping_pe_human/Log.progress.out
    type: File?
    'sbg:x': 203
    'sbg:y': -268
  - id: SJ.out.tab_human
    outputSource:
      - star_mapping_pe_human/SJ.out.tab
    type: File?
    'sbg:x': 206
    'sbg:y': -521.0446166992188
  - id: aligned_bam_human
    outputSource:
      - star_mapping_pe_human/aligned
    type: File
    'sbg:x': 57.4921875
    'sbg:y': 130.5
  - id: output_unmapped
    outputSource:
      - samtools_view/output
    type: File
    'sbg:x': 412
    'sbg:y': 218
  - id: output_fq2
    outputSource:
      - bedtools_bamtofastq_pe/output_fq2
    type: File?
    'sbg:x': 591.3458862304688
    'sbg:y': -329.0044250488281
  - id: output_fq1
    outputSource:
      - bedtools_bamtofastq_pe/output_fq1
    type: File
    'sbg:x': 589.410888671875
    'sbg:y': -168.9302978515625
  - id: SJ.out.tab_virus
    outputSource:
      - star_mapping_pe_virus/SJ.out.tab
    type: File?
    'sbg:x': 1034.0048828125
    'sbg:y': 17.815855026245117
  - id: Log.progress.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.progress.out
    type: File?
    'sbg:x': 1032.626220703125
    'sbg:y': 293.0771179199219
  - id: Log.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.out
    type: File?
    'sbg:x': 1034.2930908203125
    'sbg:y': 438.0975341796875
  - id: aligned_virus
    outputSource:
      - star_mapping_pe_virus/aligned
    type: File
    'sbg:x': 1040.3548583984375
    'sbg:y': 629.8064575195312
  - id: mappingstats_virus
    outputSource:
      - star_mapping_pe_virus/mappingstats
    type: File?
    'sbg:x': 1038.330322265625
    'sbg:y': 146.6676025390625
  - id: mappingstats_human
    outputSource:
      - star_mapping_pe_human/mappingstats
    type: File?
    'sbg:x': 206.1626434326172
    'sbg:y': -394.3936767578125
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
      - id: b
        default: true
      - id: f
        default: 4
      - id: prefix
        default: human
      - id: bam
        source: star_mapping_pe_human/aligned
    out:
      - id: output
    run: ../tool/samtools/samtools-view.cwl
    label: samtools-view
    'sbg:x': 256
    'sbg:y': 97
  - id: bedtools_bamtofastq_pe
    in:
      - id: input
        source: samtools_view/output
      - id: fq
        default: unmapped_1.fq
      - id: fq2
        default: unmapped_2.fq
    out:
      - id: output_fq1
      - id: output_fq2
    run: ../tool/bedtools/bedtools-bamtofastq-pe.cwl
    label: bedtools-bamtofastq-pe
    'sbg:x': 445
    'sbg:y': 37
  - id: star_mapping_pe_virus
    in:
      - id: fq1
        source: bedtools_bamtofastq_pe/output_fq1
      - id: fq2
        source: bedtools_bamtofastq_pe/output_fq2
      - id: genomeDir
        source: genomeDir_virus
      - id: nthreads
        source: nthreads
      - id: outFileNamePrefix
        default: virus
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
    'sbg:x': 792.4325561523438
    'sbg:y': 221.78775024414062
requirements: []
