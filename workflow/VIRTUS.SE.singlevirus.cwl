#!/usr/bin/env cwltool

class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__p_e_singlevirus
doc: >-
  STAR mapping and salmon quantification for one specified virus. Prepare using
  create_singlevirus.cwl beforehand. version 1.0.0
label: VIRTUS.PE.singlevirus
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: genomeDir_singlevirus
    type: Directory
    'sbg:x': -619
    'sbg:y': -446
  - id: salmon_index_singlevirus
    type: Directory
    'sbg:x': -631
    'sbg:y': -699
  - id: quantdir
    type: string
    'sbg:x': -631
    'sbg:y': -821
  - id: outFileNamePrefix_star
    type: string?
    'sbg:x': -622
    'sbg:y': -568
  - id: runThreadN
    type: int?
    'sbg:x': -632
    'sbg:y': -24
  - id: fq_unmapped
    type: File
    'sbg:x': -632.209716796875
    'sbg:y': 127.91934967041016
outputs:
  - id: output_quantdir
    outputSource:
      - salmon_quant_se/output_quantdir
    type: Directory
    'sbg:x': -113.24195098876953
    'sbg:y': -608.2741088867188
  - id: SJ.out.tab
    outputSource:
      - star_mapping_se/SJ.out.tab
    type: File?
    'sbg:x': -78.89515686035156
    'sbg:y': -388.05645751953125
  - id: mappingstats
    outputSource:
      - star_mapping_se/mappingstats
    type: File?
    'sbg:x': -75.85482788085938
    'sbg:y': -236.25038146972656
  - id: aligned
    outputSource:
      - star_mapping_se/aligned
    type: File
    'sbg:x': -65.72579193115234
    'sbg:y': 26
  - id: Log.out
    outputSource:
      - star_mapping_se/Log.out
    type: File?
    'sbg:x': -77.95967864990234
    'sbg:y': -107.8790283203125
steps:
  - id: salmon_quant_se
    in:
      - id: index
        source: salmon_index_singlevirus
      - id: inf
        source: fq_unmapped
      - id: libType
        default: A
      - id: quantdir
        source: quantdir
      - id: runThreadN
        source: runThreadN
      - id: gcBias
        default: true
      - id: validateMappings
        default: true
    out:
      - id: output_quantdir
    run: ../tool/salmon-cwl/salmon-quant_se.cwl
    'sbg:x': -352.3951721191406
    'sbg:y': -572.12890625
  - id: star_mapping_se
    in:
      - id: fq
        source: fq_unmapped
      - id: genomeDir
        source: genomeDir_singlevirus
      - id: nthreads
        source: runThreadN
      - id: outFileNamePrefix
        source: outFileNamePrefix_star
      - id: outSAMtype
        default: 'BAM SortedByCoordinate '
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
    'sbg:x': -310.71771240234375
    'sbg:y': -223.00827026367188
requirements: []
'sbg:toolAuthor': Yoshiaki Yasumizu
