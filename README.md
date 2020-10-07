# VIRTUS : VIRal Transcript Usage Sensor v1.1 <img src="https://github.com/yyoshiaki/VIRTUS/raw/master/img/VIRTUS.jpg" width="20%" align="right" />

Virus transcript detection and quantification using normal human RNAseq. VIRTUS is the first tool to detect viral transcripts considering their splicing event rather than the viral genome copy number. VIRTUS can be applied to both bulk RNAseq and single-cell RNAseq. The virus reference covers 762 viruses including SARS-CoV-2 (cause of COVID-19). The workflow is implemented by [Common Workflow Language](https://www.commonwl.org/) and [Rabix](https://rabix.io/). You can specify each parameter individually or give `yaml` or `json` file which describes all the parameter information. In detail, check [the CWL User Guide](http://www.commonwl.org/user_guide/) out. 

![img](https://github.com/yyoshiaki/VIRTUS/raw/master/img/webimage.jpg)

## Documentation

**First, refer to [WIKI](https://github.com/yyoshiaki/VIRTUS/wiki). We recommend walking through [Quick tutorial](https://github.com/yyoshiaki/VIRTUS/wiki/Quick-tutorial-(installation,-create-index,-and-first-run)).**


## Contact

Yoshiaki Yasumizu ([yyasumizu@ifrec.osaka-u.ac.jp](yyasumizu@ifrec.osaka-u.ac.jp))

## Citation

VIRTUS: a pipeline for comprehensive virus analysis from conventional RNA-seq data
Yasumizu, Yoshiaki, Atsushi Hara, Shimon Sakaguchi, and Naganari Ohkura. 2020. “OUP Accepted Manuscript.” Edited by Jan Gorodkin. *Bioinformatics*, October. https://doi.org/10.1093/bioinformatics/btaa859.

## Acknowledgement

- [Kozo Nishida](https://github.com/kozo2) : CI config and many other supports.
- Ayano Onishi : Logo design.

## Licence

This software is freely available for academic users. Usage for commercial purposes is not allowed. Please refer to the LICENCE page.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a>
