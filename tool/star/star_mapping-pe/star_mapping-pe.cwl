class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'https://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - STAR
  - '--runMode'
  - alignReads
inputs:
  - default: 1000000
    id: alignIntronMax
    type: int?
    inputBinding:
      position: 0
      prefix: '--alignIntronMax'
    label: maximum intron size
    doc: >-
      maximum intron size, if 0, max intron size will be determined by
      (2ˆwinBinNbits)*winAnchorDistNbins
  - default: 20
    id: alignIntronMin
    type: int?
    inputBinding:
      position: 0
      prefix: '--alignIntronMin'
    label: minimum intron size
    doc: >-
      minimum intron size: genomic gap is considered intron if its
      length>=alignIntronMin, otherwise it is considered Deletion
  - default: 1000000
    id: alignMatesGapMax
    type: int?
    inputBinding:
      position: 0
      prefix: '--alignMatesGapMax'
    label: maximum gap between two mates
    doc: >-
      maximum gap between two mates, if 0, max intron gap will be determined by
      (2ˆwinBinNbits)*winAnchorDistNbins
  - default: 1
    id: alignSJDBoverhangMin
    type: int?
    inputBinding:
      position: 0
      prefix: '--alignSJDBoverhangMin'
    label: minimum overhang (i.e. block size) for annotated (sjdb) spliced alignments
    doc: minimum overhang (i.e. block size) for annotated (sjdb) spliced alignments
  - default: 8
    id: alignSJoverhangMin
    type: int?
    inputBinding:
      position: 0
      prefix: '--alignSJoverhangMin'
    label: minimum overhang (i.e. block size) for spliced alignments
    doc: minimum overhang (i.e. block size) for spliced alignments
  - id: fq1
    type: File
    inputBinding:
      position: 50
      prefix: '--readFilesIn'
    label: path to file that contain input read1
    doc: path to file that contain input read1
  - id: fq2
    type: File
    inputBinding:
      position: 51
    label: path to file that contain input read2
    doc: path to file that contain input read2
  - id: genomeDir
    type: Directory
    inputBinding:
      position: 0
      prefix: '--genomeDir'
    label: path to the directory where genome files are stored
    doc: path to the directory where genome files are stored
  - id: limitBAMsortRAM
    type: long?
    inputBinding:
      position: 0
      prefix: '--limitBAMsortRAM'
    label: maximum available RAM for sorting BAM
    doc: >-
      maximum available RAM for sorting BAM. If =0, it will be set to the genome
      index size. 0 value can only be used with –genomeLoad NoSharedMemory
      option
  - id: nthreads
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
    label: Number of threads
    doc: >-
      defines the number of threads to be used for genome generation, it has to
      be set to the number of available cores on the server node.
  - default: 10
    id: outBAMcompression
    type: int?
    inputBinding:
      position: 0
      prefix: '--outBAMcompression'
    label: BAM compression level
    doc: >-
      BAM compression level, -1=default compression (6?), 0=no compression,
      10=maximum compression
  - default: 999
    id: outFilterMismatchNmax
    type: int?
    inputBinding:
      position: 0
      prefix: '--outFilterMismatchNmax'
    label: alignment will be output only if it has no more mismatches than this value
    doc: alignment will be output only if it has no more mismatches than this value
  - default: 0.04
    id: outFilterMismatchNoverReadLmax
    type: float?
    inputBinding:
      position: 0
      prefix: '--outFilterMismatchNoverReadLmax'
    label: >-
      alignment will be output only if its ratio of mismatches to *read* length
      is less than or equal to this value.
    doc: >-
      alignment will be output only if its ratio of mismatches to *read* length
      is less than or equal to this value.
  - default: 20
    id: outFilterMultimapNmax
    type: int?
    inputBinding:
      position: 0
      prefix: '--outFilterMultimapNmax'
    label: maximum number of loci the read is allowed to map to
    doc: >-
      maximum number of loci the read is allowed to map to. Alignments (all of
      them) will be output only if the read maps to no more loci than this
      value. Otherwise no alignments will be output, and the read will be
      counted as ”mapped to too many loci” in the Log.final.out .
  - default: BySJout
    id: outFilterType
    type: string?
    inputBinding:
      position: 0
      prefix: '--outFilterType'
    label: type of filtering
    doc: >-
      Normal: standard filtering using only current alignment, BySJout: keep
      only those reads that contain junctions that passed filtering into
      SJ.out.tab
  - default:
      - NH
      - HI
      - AS
      - NM
      - MD
    id: outSAMattributes
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--outSAMattributes'
    label: >-
      a string of desired SAM attributes, in the order desired for the output
      SAM
    doc: >-
      NH: any combination in any order, Standard: NH HI AS nM, All: NH HI AS nM
      NM MD jM jI ch, None: no attributes
  - default: intronMotif
    id: outSAMstrandField
    type: string?
    inputBinding:
      position: 0
      prefix: '--outSAMstrandField'
    label: Cuffinks-like strand field flag
    doc: >-
      Cuffinks-like strand field flag. None: not used, intronMotif: strand
      derived from the intron motif. Reads with inconsistent and/or
      non-canonical introns are filtered out.
  - default:
      - BAM
      - Unsorted
    id: outSAMtype
    type: 'string[]?'
    inputBinding:
      position: 1
      prefix: '--outSAMtype'
      shellQuote: false
    label: type of SAM/BAM output
    doc: >-
      1st word: BAM: output BAM without sorting, SAM: output SAM without
      sorting, None: no SAM/BAM output, 2nd, 3rd: Unsorted: standard unsorted,
      SortedByCoordinate: sorted by coordinate. This option will allocate extra
      memory for sorting which can be specified by –limitBAMsortRAM
  - default: Within
    id: outSAMunmapped
    type: string?
    inputBinding:
      position: 0
      prefix: '--outSAMunmapped'
    label: output of unmapped reads in the SAM format
    doc: >-
      1st word: None: no output, Within: output unmapped reads within the main
      SAM file (i.e. Aligned.out.sam). 2nd word: KeepPairs: record unmapped mate
      for each alignment, and, in case of unsorted output, keep it adjacent to
      its mapped mate. Only a↵ects multi-mapping reads.
  - default: Unique
    id: outSJfilterReads
    type: string?
    inputBinding:
      position: 0
      prefix: '--outSJfilterReads'
    label: which reads to consider for collapsed splice junctions output
    doc: >-
      which reads to consider for collapsed splice junctions output. All: all
      reads, unique- and multi-mappers, Unique: uniquely mapping reads only.
  - default: STAR
    id: output_dir_name
    type: string?
    label: Name of the directory to write output files in
    doc: Name of the directory to write output files in
  - default: 10
    id: quantTranscriptomeBAMcompression
    type: int?
    inputBinding:
      position: 0
      prefix: '--quantTranscriptomeBAMcompression'
    label: transcriptome BAM compression level
    doc: >-
      transcriptome BAM compression level, -1=default compression (6?), 0=no
      compression, 10=maximum compression
  - default: 1
    id: sjdbScore
    type: int?
    inputBinding:
      position: 0
      prefix: '--sjdbScore'
    label: extra alignment score for alignmets that cross database junctions
    doc: extra alignment score for alignmets that cross database junctions
  - id: outFileNamePrefix
    type: string?
    inputBinding:
      position: 0
      prefix: '--outFileNamePrefix'
  - id: readFilesCommand
    type: string?
    inputBinding:
      position: 0
      prefix: '--readFilesCommand'
outputs:
  - id: aligned
    type: File
    outputBinding:
      glob: |
        ${
          if (inputs.outSAMtype == "BAM Unsorted")
            return p+"Aligned.out.bam";
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Aligned.sortedByCoord.out.bam";
        }
    secondaryFiles:
      - |
        ${
           var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
           return [
             {"path": p+"Log.final.out", "class":"File"},
             {"path": p+"SJ.out.tab", "class":"File"},
             {"path": p+"Log.out", "class":"File"}
           ];
        }
  - id: bamRemDups
    type: File?
    outputBinding:
      glob: |
        ${
          if (inputs.bamRemoveDuplicatesType != "UniqueIdentical")
            return null;
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Processed.out.bam";
        }
  - id: mappingstats
    type: File?
    outputBinding:
      loadContents: true
      glob: |
        ${
          var p = inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Log.final.out";
        }
  - id: readspergene
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"ReadsPerGene.out.tab";
        }
  - id: transcriptomesam
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Aligned.toTranscriptome.out.bam";
        }
  - id: Log.out
    type: File?
    outputBinding:
      glob: >-
        ${   var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";  
        return p+"Log.out"; }
  - id: Log.progress.out
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Log.progress.out";
        }
  - id: SJ.out.tab
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"SJ.out.tab";
        }
  - id: unmapped
    type: File?
    outputBinding:
      glob: $(inputs.outSAMunmapped)
doc: >-
  STAR: Spliced Transcripts Alignment to a Reference.
  https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf
label: 'STAR mapping: running mapping jobs.'
requirements:
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomeDir)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/star:2.7.1a--0'
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
