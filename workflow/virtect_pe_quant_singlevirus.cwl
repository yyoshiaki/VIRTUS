#!/usr/bin/env cwltool

class: Workflow
cwlVersion: v1.0
id: virtect_pe_quant_singlevirus
doc: >-
  STAR mapping and salmon quantification for one specified virus. Prepare using
  create_singlevirus.cwl beforehand. version 1.0.0
label: virtect_pe_quant_singlevirus
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fq2_unmapped
    type: File
    'sbg:x': -620
    'sbg:y': -304
  - id: fq1_unmapped
    type: File
    'sbg:x': -623
    'sbg:y': -175
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
outputs:
  - id: SJ.out.tab
    outputSource:
      - star_mapping_pe/SJ.out.tab
    type: File?
    'sbg:x': -106
    'sbg:y': -420
  - id: mappingstats
    outputSource:
      - star_mapping_pe/mappingstats
    type: File?
    'sbg:x': -106.39886474609375
    'sbg:y': -280
  - id: Log.progress.out
    outputSource:
      - star_mapping_pe/Log.progress.out
    type: File?
    'sbg:x': -97.39886474609375
    'sbg:y': -150
  - id: Log.out
    outputSource:
      - star_mapping_pe/Log.out
    type: File?
    'sbg:x': -82
    'sbg:y': 9
  - id: aligned
    outputSource:
      - star_mapping_pe/aligned
    type: File
    'sbg:x': -86
    'sbg:y': 169
  - id: output_quantdir
    outputSource:
      - salmon_quant/output_quantdir
    type: Directory
    'sbg:x': -74
    'sbg:y': -627
steps:
  - id: star_mapping_pe
    in:
      - id: fq1
        source: fq1_unmapped
      - id: fq2
        source: fq2_unmapped
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
    run: ../tool/star/star_mapping-pe/star_mapping-pe.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': -349
    'sbg:y': -316
  - id: salmon_quant
    in:
      - id: index
        source: salmon_index_singlevirus
      - id: inf1
        source: fq1_unmapped
      - id: inf2
        source: fq2_unmapped
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
    run: ../tool/salmon-cwl/salmon-quant.cwl
    'sbg:x': -282
    'sbg:y': -625
requirements: []
'sbg:toolAuthor': Yoshiaki Yasumizu
