#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
doc: The non-interactive network downloader
requirements:
  DockerRequirement:
    dockerPull: alpine:3.9
  InlineJavascriptRequirement: {}
baseCommand: wget
inputs:
  url:
    doc: Download target URL
    type: string
    inputBinding: {}
  output_name:
    doc: Output file name (use `wget-stdout.txt` by default)
    type: string
    default: wget-stdout.txt
    inputBinding:
      prefix: --output-document=
      separate: false
      valueFrom: "$(inputs.use_remote_name ? inputs.url.split('/').pop() : self)"
  use_remote_name:
    doc: Use the basename of `url` parameter as an output file name. It is equivalent to `curl -O`.
    type: boolean
    default: false
outputs:
  downloaded:
    type: File
    outputBinding:
      glob: "$(inputs.use_remote_name ? inputs.url.split('/').pop() : inputs.output_name)"
  stderr: stderr
stderr: wget-stderr.log
