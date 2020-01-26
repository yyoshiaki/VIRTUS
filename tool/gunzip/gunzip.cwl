class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - gunzip
  - '--stdout'
inputs:
  - id: file
    type: File
    inputBinding:
      position: 0
outputs:
  - id: decompressed
    type: stdout
  - id: stderr
    type: stderr
doc: decompression tool using Lempel-Ziv coding (LZ77)
requirements:
  - class: DockerRequirement
    dockerPull: 'alpine:3.9'
  - class: InlineJavascriptRequirement
stdout: $(inputs.file.nameroot)
stderr: gunzip-stderr.log
