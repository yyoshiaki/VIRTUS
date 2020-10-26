class: Workflow
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'https://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: runThreadN
    type: int?
    'sbg:x': -232
    'sbg:y': -321
  - id: url_genomefasta
    type: string
    'sbg:x': -679
    'sbg:y': -90.99568176269531
  - id: output_name_genomefasta
    type: string
    'sbg:x': -675
    'sbg:y': 50.00431823730469
  - id: dir_name
    type: string
    'sbg:x': -505.46875
    'sbg:y': 335
  - id: genomeSAindexNbases
    type: int?
    'sbg:x': -227
    'sbg:y': -181
outputs:
  - id: downloaded_genomefasta
    outputSource:
      - wget_genomefasta/downloaded
    type: File
    'sbg:x': -426
    'sbg:y': 130
  - id: starIndex
    outputSource:
      - star_index/starIndex
    type: Directory
    'sbg:x': 304.6953125
    'sbg:y': -14.5
steps:
  - id: star_index
    in:
      - id: genomeDir
        source: mkdir/created_directory
      - id: genomeFastaFiles
        source: gunzip_genomefasta/decompressed
      - id: runThreadN
        default: '4'
        source: runThreadN
      - id: genomeSAindexNbases
        default: 14
        source: genomeSAindexNbases
    out:
      - id: starIndex
    run: ../../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': 78
    'sbg:y': -19
  - id: wget_genomefasta
    in:
      - id: output_name
        source: output_name_genomefasta
      - id: url
        source: url_genomefasta
    out:
      - id: downloaded
      - id: stderr
    run: ../../tool/wget/wget.cwl
    'sbg:x': -541
    'sbg:y': -20
  - id: mkdir
    in:
      - id: dir_name
        source: dir_name
    out:
      - id: created_directory
    run: ../../tool/mkdir/mkdir.cwl
    label: Make directory if not exists
    'sbg:x': -292.46875
    'sbg:y': 237.5
  - id: gunzip_genomefasta
    in:
      - id: file
        source: wget_genomefasta/downloaded
    out:
      - id: decompressed
      - id: stderr
    run: ../../tool/gunzip/gunzip.cwl
    'sbg:x': -233
    'sbg:y': -35
requirements: []
's:author':
  - class: 's:Person'
    's:email': 'mailto:inutano@gmail.com'
    's:identifier': 'https://orcid.org/0000-0003-3777-5945'
    's:name': Tazro Ohta
's:codeRepository': 'https://github.com/pitagora-network/pitagora-cwl'
's:license': 'https://spdx.org/licenses/Apache-2.0'
