#!/bin/bash
top_dir=`pwd`
n_para4snaphu_opt=8
binpath=/usr/local/InSAR_processing/script
coherence_thre=0.35
common_master_date=20200317
width=`awk '$1=="width:" {print $2}' $top_dir/IFGs/$common_master_date/dem_seg.par`
echo "width=$width"
mkdir snaphu_opt
cd snaphu_opt
mkdir configs
mkdir snaphu_out
if [ $# -ge 1 ]
then
	un_err_list=$1
        if [ -f "$top_dir/$un_err_list" ]
	then
		cp $top_dir/$un_err_list ./
	else
		echo "No exiting the list of phs containing unwrapped errors!"
		exit
	fi
else
        echo "Please add the path of list !"
	exit
fi

if [ -f "$top_dir/parallel_snaphu.txt" ]
then 
	rm $top_dir/parallel_snaphu.txt
fi

#touch the configs of snaphu!
cd configs
cat $top_dir/snaphu_opt/$un_err_list | while read line
do
	date=${line:0:8}-${line:9:8}
	out_name=$date.snaphu.opt
	touch $date.conf
	echo INFILE $top_dir/IFGs/$date/result/$date.phs >> $date.conf
	echo LINELENGTH $width >> $date.conf
	echo OUTFILE $top_dir/snaphu_opt/snaphu_out/$out_name >> $date.conf
	echo CORRFILE $top_dir/IFGs/$date/result/$date.coherence >> $date.conf
	echo LOGFILE $top_dir/snaphu_opt/snaphu_out/$out_name.log >> $date.conf
	echo STATCOSTMODE DEFO >> $date.conf
	echo INITONLY FALSE >> $date.conf
	echo UNWRAPPED_IN TRUE >> $date.conf
	echo INFILEFORMAT FLOAT_DATA >> $date.conf
	echo OUTFILEFORMAT FLOAT_DATA >> $date.conf
	echo CORRFILEFORMAT FLOAT_DATA >> $date.conf
	echo ESTFILEFORMAT FLOAT_DATA >> $date.conf
	echo UNWRAPPEDINFILEFORMAT FLOAT_DATA >> $date.conf
	echo INITMAXFLOW 0 >> $date.conf
	echo MAXFLOW 2 >> $date.conf
	echo "$top_dir/snaphu_parallel.sh $top_dir $date $width $coherence_thre" >> $top_dir/parallel_snaphu.txt
done
parallel -j $n_para4snaphu_opt < $top_dir/parallel_snaphu.txt > paralog
echo "*************************************************************"
echo "*******************snaphu opt finished!**********************"
echo "*************************************************************"






