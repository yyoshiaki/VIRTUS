FROM quay.io/biocontainers/samtools:1.2-0

WORKDIR /workdir
COPY bam_filter_polyx.sh /workdir
RUN chmod 777 bam_filter_polyx.sh
ENV PATH $PATH:/workdir