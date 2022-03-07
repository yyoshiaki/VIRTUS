FROM quay.io/biocontainers/samtools:1.15--h1170115_1

WORKDIR /workdir
COPY bam_filter_polyx.sh /workdir
COPY samtools_view_removemulti.sh /workdir
RUN chmod 777 bam_filter_polyx.sh
RUN chmod 777 samtools_view_removemulti.sh
ENV PATH $PATH:/workdir