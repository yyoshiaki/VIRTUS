class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'https://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - STAR
  - '--runMode'
  - genomeGenerate
inputs:
  - id: genomeDir
    type: Directory
    inputBinding:
      position: 0
      prefix: '--genomeDir'
  - id: genomeFastaFiles
    type: File
    inputBinding:
      position: 0
      prefix: '--genomeFastaFiles'
  - id: runThreadN
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
  - id: sjdbGTFfile
    type: File?
    inputBinding:
      position: 0
      prefix: '--sjdbGTFfile'
  - id: sjdbOverhang
    type: int?
    inputBinding:
      position: 0
      prefix: '--sjdbOverhang'
  - id: genomeSAindexNbases
    type: int?
    inputBinding:
      position: 4
      prefix: '--genomeSAindexNbases'
outputs:
  - id: starIndex
    type: Directory
    outputBinding:
      glob: $(inputs.genomeDir.basename)
doc: >-
  STAR: Spliced Transcripts Alignment to a Reference.
  https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf
label: 'STAR genomeGenerate: Generating genome indexes.'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomeDir)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/star:2.7.1a--0'
's:author':
  - class: 's:Person'
    's:email': 'mailto:inutano@gmail.com'
    's:identifier': 'https://orcid.org/0000-0003-3777-5945'
    's:name': Tazro Ohta
's:codeRepository': 'https://github.com/pitagora-network/pitagora-cwl'
's:license': 'https://spdx.org/licenses/Apache-2.0'
