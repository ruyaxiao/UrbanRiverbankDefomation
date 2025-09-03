#!/bin/bash
top_dir=$1
date=$2
width=$3
coherence_thre=$4
binpath=/usr/local/InSAR_processing/script
echo "*************************************************************"
echo "      ${date}.phs is doing snaphu now ! "
echo "*************************************************************"
snaphu -f $top_dir/snaphu_opt/configs/$date.conf
if [ -f "$top_dir/snaphu_opt/snaphu_out/${date}.snaphu.opt" ]
then
	mv $top_dir/IFGs/${date}/result/${date}.phs $top_dir/IFGs/${date}/result/${date}.old.phs
	mv $top_dir/IFGs/${date}/result/${date}.phs.jpg $top_dir/IFGs/${date}/result/${date}.old.phs.jpg
	mv $top_dir/IFGs/${date}/result/${date}.phs.bmp $top_dir/IFGs/${date}/result/${date}.old.phs.bmp
	swap_bytes $top_dir/snaphu_opt/snaphu_out/$date.snaphu.opt $top_dir/snaphu_opt/snaphu_out/$date.snaphu.opt.big 4
	swap_bytes $top_dir/IFGs/$date/result/$date.coherence $top_dir/IFGs/$date/result/$date.coherence.big 4
	rascc_mask $top_dir/IFGs/$date/result/$date.coherence.big - $width 1 1 0 1 1 $coherence_thre 0 0.2 0.8 1. .35 1 $top_dir/IFGs/$date/result/$date.mask.bmp
	mask_data $top_dir/snaphu_opt/snaphu_out/$date.snaphu.opt.big $width $top_dir/snaphu_opt/snaphu_out/$date.snaphu.opt.big.mskd $top_dir/IFGs/$date/result/$date.mask.bmp 0
	ln -s $top_dir/snaphu_opt/snaphu_out/$date.snaphu.opt.big.mskd $top_dir/IFGs/$date/result/$date.phs.big
	rasdt_pwr $top_dir/IFGs/$date/result/$date.phs.big - $width - - - - -9.32 9.32 1 rmg.cm $top_dir/IFGs/$date/result/$date.phs.bmp
	swap_bytes $top_dir/IFGs/$date/result/$date.phs.big $top_dir/IFGs/$date/result/$date.phs 4
	echo $date >> $top_dir/snaphu_opt/opted_date_list
	cd $top_dir/IFGs/$date/result
	${binpath}/plotztd.gmt $date.phs $date.phs.rsc
	rm $date.coherence.big
	rm $date.phs.big
	cd $top_dir
	echo "*******************************************************"
	echo "     ${date}.phs snaphu is over !       "
	echo "*******************************************************"
else
	echo $date >> $top_dir/snaphu_opt/unopted_date_list
fi
