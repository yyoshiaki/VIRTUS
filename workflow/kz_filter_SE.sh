kz -k 2 < unmapped.fq > kz.txt

SCRIPT_DIR=$(cd $(dirname $0); pwd)
python3 $SCRIPT_DIR/kz_list_SE.py

list=(`cat kz_filter_list.txt`)
samtools view virusAligned.filtered.sortedByCoord.out.bam | egrep -v "`echo $(IFS="|"; echo "${list[*]}")`" | cut -f3 | sort | uniq -c  > virus_counts_kz.txt
samtools view virusAligned.filtered.sortedByCoord.out.bam | egrep "`echo $(IFS="|"; echo "${list[*]}")`" > kz_removed.txt