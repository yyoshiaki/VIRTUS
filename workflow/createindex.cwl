class: Workflow
cwlVersion: v1.0
id: createindex
label: CreateIndex
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: url_virus
    type: string
    'sbg:x': -1123.8369140625
    'sbg:y': -782.5
  - id: output_name_virus
    type: string
    'sbg:x': -1117.8369140625
    'sbg:y': -653.5
  - id: runThreadN
    type: int?
    'sbg:x': -973
    'sbg:y': -242
  - id: dir_name
    type: string
    'sbg:x': -1123.5
    'sbg:y': -474.5
outputs:
  - id: downloaded_virus
    outputSource:
      - wget_virus/downloaded
    type: File
    'sbg:x': -752.8369140625
    'sbg:y': -777.5
  - id: starIndex_virus
    outputSource:
      - star_index_virus/starIndex
    type: Directory
    'sbg:x': -486.8369140625
    'sbg:y': -606.5
steps:
  - id: star_index_virus
    in:
      - id: genomeDir
        source: mkdir_virus/created_directory
      - id: genomeFastaFiles
        source: wget_virus/downloaded
      - id: runThreadN
        source: runThreadN
    out:
      - id: starIndex
    run: ../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': -709.8369140625
    'sbg:y': -605.5
  - id: mkdir_virus
    in:
      - id: dir_name
        default: STAR_index_virus
        source: dir_name
    out:
      - id: created_directory
    run: ../tool/mkdir/mkdir.cwl
    label: Make directory if not exists
    'sbg:x': -977
    'sbg:y': -478
  - id: wget_virus
    in:
      - id: output_name
        source: output_name_virus
      - id: url
        source: url_virus
    out:
      - id: downloaded
      - id: stderr
    run: ../tool/wget/wget.cwl
    'sbg:x': -954
    'sbg:y': -720
requirements: []
