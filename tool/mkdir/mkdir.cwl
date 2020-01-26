#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Make directory if not exists
doc: Make directory if not exists
requirements:
  DockerRequirement:
    dockerPull: alpine:3.10.0
  InlineJavascriptRequirement: {}
baseCommand: ["mkdir", "-p"]

inputs:
  dir_name:
    type: string
    inputBinding:
      position: 0

outputs:
  created_directory:
    type: Directory
    outputBinding:
      glob: $(inputs.dir_name)

