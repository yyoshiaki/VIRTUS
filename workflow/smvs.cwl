class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__s_e
doc: VIRTUS v1.0
label: smvs
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: nthreads
    type: int?
    'sbg:x': -109.26367950439453
    'sbg:y': 303
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 447.2225036621094
    'sbg:y': -263.0279846191406
  - id: hit_cutoff
    type: int?
    'sbg:x': 738.9225463867188
    'sbg:y': 519.65234375
  - id: bam
    type: File
    'sbg:x': -106.00248718261719
    'sbg:y': 74.46144104003906
  - id: input_STARLog
    type: File
    'sbg:x': 876.682861328125
    'sbg:y': -559.8308715820312
outputs:
  - id: output_unmapped
    outputSource:
      - samtools_view/output
    type: File
    'sbg:x': 412
    'sbg:y': 218
  - id: output
    outputSource:
      - mk_summary_virus_count/output
    type: File?
    'sbg:x': 1280.2369384765625
    'sbg:y': -573.7061767578125
  - id: output_fq
    outputSource:
      - bedtools_bamtofastq_se/output_fq
    type: File
    'sbg:x': 605.4130859375
    'sbg:y': -62.6005744934082
  - id: SJ.out.tab_virus
    outputSource:
      - star_mapping_se_virus/SJ.out.tab
    type: File?
    'sbg:x': 848.7875366210938
    'sbg:y': -104.10987854003906
  - id: mappingstats_virus
    outputSource:
      - star_mapping_se_virus/mappingstats
    type: File?
    'sbg:x': 889.2903442382812
    'sbg:y': 25.706695556640625
  - id: Log.out_virus
    outputSource:
      - star_mapping_se_virus/Log.out
    type: File?
    'sbg:x': 916.2921752929688
    'sbg:y': 166.94712829589844
  - id: aligned_bam_virus
    outputSource:
      - star_mapping_se_virus/aligned
    type: File
    'sbg:x': 844.6334228515625
    'sbg:y': 646.7491455078125
  - id: aligned_bam_virus_filtered
    outputSource:
      - bam_filter_polyx/output
    type: File?
    'sbg:x': 949.710693359375
    'sbg:y': 282.77105712890625
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
        default: SE
    out:
      - id: output
    run: ../tool/mk_summary_virus_count/mk_summary_virus_count.cwl
    label: mk_summary_virus_count
    'sbg:x': 1132.9288330078125
    'sbg:y': -576.298583984375
  - id: bedtools_bamtofastq_se
    in:
      - id: input
        source: samtools_view/output
      - id: fq
        default: unmapped.fq
    out:
      - id: output_fq
    run: ../tool/bedtools/bedtools-bamtofastq-se.cwl
    label: bedtools-bamtofastq-pe
    'sbg:x': 392.1208801269531
    'sbg:y': -110.00155639648438
  - id: star_mapping_se_virus
    in:
      - id: fq
        source: bedtools_bamtofastq_se/output_fq
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
    run: ../tool/star/star_mapping-se/star_mapping-se.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': 722.9669799804688
    'sbg:y': 137.9506378173828
  - id: bam_filter_polyx
    in:
      - id: input
        source: star_mapping_se_virus/aligned
    out:
      - id: output
    run: ../tool/samtools/bam_filter_polyx.cwl
    label: bam_filter_polyX
    'sbg:x': 847.6024780273438
    'sbg:y': 366.4100036621094
requirements: []
'sbg:license': CC BY-NC 4.0
'sbg:links':
  - id: 'https://github.com/yyoshiaki/VIRTUS'
    label: ''
'sbg:toolAuthor': Yoshiaki Yasumizu
