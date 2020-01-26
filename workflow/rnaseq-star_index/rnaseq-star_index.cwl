class: Workflow
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'https://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: runThreadN
    type: string?
    'sbg:x': -98
    'sbg:y': 229
  - id: url_gtf
    type: string
    'sbg:x': -607
    'sbg:y': -378
  - id: output_name_gtf
    type: string
    'sbg:x': -630
    'sbg:y': -227.9956817626953
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
outputs:
  - id: starIndex
    outputSource:
      - star_index/starIndex
    type: Directory
    'sbg:x': 300
    'sbg:y': -109
  - id: downloaded_gtf
    outputSource:
      - wget_gtf/downloaded
    type: File
    'sbg:x': -354.08599853515625
    'sbg:y': -405.5
  - id: downloaded_genomefasta
    outputSource:
      - wget_genomefasta/downloaded
    type: File
    'sbg:x': -426
    'sbg:y': 130
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
      - id: sjdbGTFfile
        source: gunzip_gtf/decompressed
    out:
      - id: starIndex
    run: ../../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': 60
    'sbg:y': -108
  - id: wget_gtf
    in:
      - id: output_name
        source: output_name_gtf
      - id: url
        source: url_gtf
    out:
      - id: downloaded
      - id: stderr
    run: ../../tool/wget/wget.cwl
    'sbg:x': -450
    'sbg:y': -265
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
  - id: gunzip_gtf
    in:
      - id: file
        source: wget_gtf/downloaded
    out:
      - id: decompressed
      - id: stderr
    run: ../../tool/gunzip/gunzip.cwl
    'sbg:x': -234.9669189453125
    'sbg:y': -189.5
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
$schemas:
  - 'https://schema.org/docs/schema_org_rdfa.html'
  - 'http://edamontology.org/EDAM_1.18.owl'
's:author':
  - class: 's:Person'
    's:email': 'mailto:inutano@gmail.com'
    's:identifier': 'https://orcid.org/0000-0003-3777-5945'
    's:name': Tazro Ohta
's:codeRepository': 'https://github.com/pitagora-network/pitagora-cwl'
's:license': 'https://spdx.org/licenses/Apache-2.0'
