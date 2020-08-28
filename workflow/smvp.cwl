class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__p_e
doc: VIRTUS v1.0
label: smvp
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: nthreads
    type: int?
    'sbg:x': -110.83831024169922
    'sbg:y': 258.9266052246094
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 417.4296875
    'sbg:y': 452.7935791015625
  - id: hit_cutoff
    type: int?
    'sbg:x': 805.1641845703125
    'sbg:y': 666.56591796875
  - id: bam
    type: File
    'sbg:x': -111.83832550048828
    'sbg:y': 73.24378967285156
  - id: input_STARLog
    type: File
    'sbg:x': 726.1741333007812
    'sbg:y': -559.9502563476562
outputs:
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
    'sbg:x': 549.3675537109375
    'sbg:y': -334.5509948730469
  - id: output_fq1
    outputSource:
      - bedtools_bamtofastq_pe/output_fq1
    type: File
    'sbg:x': 562.6327514648438
    'sbg:y': -168
  - id: SJ.out.tab_virus
    outputSource:
      - star_mapping_pe_virus/SJ.out.tab
    type: File?
    'sbg:x': 954.8983154296875
    'sbg:y': -110.67289733886719
  - id: Log.progress.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.progress.out
    type: File?
    'sbg:x': 959.8370361328125
    'sbg:y': 193.0820770263672
  - id: Log.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.out
    type: File?
    'sbg:x': 960.4492797851562
    'sbg:y': 331.1433410644531
  - id: aligned_virus
    outputSource:
      - star_mapping_pe_virus/aligned
    type: File
    'sbg:x': 862.1668090820312
    'sbg:y': 348.64471435546875
  - id: mappingstats_virus
    outputSource:
      - star_mapping_pe_virus/mappingstats
    type: File?
    'sbg:x': 956.122802734375
    'sbg:y': 39.143333435058594
  - id: output
    outputSource:
      - mk_summary_virus_count/output
    type: File?
    'sbg:x': 1280.2369384765625
    'sbg:y': -573.7061767578125
  - id: output_1
    outputSource:
      - bam_filter_polyx/output
    type: File?
    'sbg:x': 967.21630859375
    'sbg:y': 668.790283203125
steps:
  - id: samtools_view
    in:
      - id: threads
        source: nthreads
      - id: f
        default: 4
      - id: prefix
        default: human
      - id: bam
        source: bam
    out:
      - id: output
    run: ../tool/samtools/samtools-view.cwl
    label: samtools-view
    'sbg:x': 199.102294921875
    'sbg:y': 52.59203338623047
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
    'sbg:x': 406.1430358886719
    'sbg:y': 28.673505783081055
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
    'sbg:x': 681.9188232421875
    'sbg:y': 132.9390411376953
  - id: mk_virus_count
    in:
      - id: virus_bam
        source: bam_filter_polyx/output
      - id: hit_cutoff
        default: 400
        source: hit_cutoff
    out:
      - id: virus_count
    run: ../tool/mk_virus_count.cwl
    label: mk_virus_count
    'sbg:x': 963.22509765625
    'sbg:y': 479.8780822753906
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: input_STARLog
      - id: input_virus_count
        source: mk_virus_count/virus_count
      - id: input_layout
        default: PE
    out:
      - id: output
    run: ../tool/mk_summary_virus_count/mk_summary_virus_count.cwl
    label: mk_summary_virus_count
    'sbg:x': 1132.9288330078125
    'sbg:y': -576.298583984375
  - id: bam_filter_polyx
    in:
      - id: input
        source: star_mapping_pe_virus/aligned
    out:
      - id: output
    run: ../tool/samtools/bam_filter_polyx.cwl
    label: bam_filter_polyX
    'sbg:x': 825.17626953125
    'sbg:y': 513.4646606445312
requirements: []
'sbg:license': CC BY-NC 4.0
'sbg:toolAuthor': Yoshiaki Yasumizu
