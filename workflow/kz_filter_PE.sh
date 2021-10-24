kz -k 2 < unmapped_1.fq > kz_1.txt
kz -k 2 < unmapped_2.fq > kz_2.txt

SCRIPT_DIR=$(cd $(dirname $0); pwd)
python3 $SCRIPT_DIR/kz_list_PE.py

list=(`cat kz_filter_list_1.txt` `cat kz_filter_list_2.txt`)

samtools view virusAligned.filtered.sortedByCoord.out.bam | egrep -v "`echo $(IFS="|"; echo "${list[*]}")`" | cut -f3 | sort | uniq -c  > virus_counts_kz.txt
samtools view virusAligned.filtered.sortedByCoord.out.bam | egrep "`echo $(IFS="|"; echo "${list[*]}")`" > kz_removed.txt