#!/bin/sh
# if [ "$3" = "" ] ; then
#  echo Usage: $0 YYYY MM RUN
#  exit 8
# fi
year=1953
month=[ 01 02 03 04 05 06 07 08 09 10 11 12 ]
MONTHS="01 02 03 04 05 06 07 08 09 10 11 12"
run=iso_anom20aa_ens01
mon=01

set -ax

yearf=1992
while [ $year -le $yearf ] ; do
 for mon in ${MONTHS} ; do 

OUTDIR=/home/ccr-01/buenning/test01/gsm_runs/iso_anom20aa_ens01_month/${year}${mon}
take_end_stream=yes
dir=/home/ccr-01/buenning/test01/gsm_runs/iso_anom20aa_ens01/${year}${mon}
GRMEAN=/home/ccr-01/buenning/test01/libs/etc/grmean
INCHOUR=/home/ccr-01/buenning/test01/libs/etc/inchour
FORCE_GRIB_DATE_MON=/home/ccr-01/buenning/test01/libs/etc/force_grib_date_mon
#
echo daily average from $year to $yearf
    cd $dir
    outdir=`eval echo $OUTDIR`
    mkdir -p $outdir 2>/dev/null
#    for mon in $month
#      do
      cd $dir
      if [ ! -s $outdir/pgb.$year$mon.avrg.grib ] ; then
	  echo Averaging month=$mon for $year dir=$dir
	  dayf=31
	  if [ $mon = "02" ] ; then
	      if [ `expr $year \% 4` -eq 0 -a $year -ne 1900 ] ; then
		  dayf=29
	      else
		  dayf=28
	      fi
	  elif [ $mon = '04' -o $mon = '06' -o $mon = '09' -o $mon = '11' ] ; then
	      dayf=30
	  fi
	  if [ $mon -eq 12 -a $year -eq 2008 ] ; then
	      dayf=25
	  fi
	  day=1
	  rm  list.$$ 2>/dev/null
	  while [ $day -le $dayf ] ; do
	      dd=$day
	      if [ $day -lt 10 ] ; then
		  dd=0$day
	      fi
	      if [ ! -s pgb.$year$mon$dd.avrg.grib ] ; then
		  echo file pgb.$year$mon$dd.avrg.grib does not exist
		  exit 8
	      fi
	      echo pgb.$year$mon$dd.avrg.grib >>list.$$
              day=`expr $day + 1`
	  done
#
	  ${GRMEAN} -s list.$$ -o $outdir/pgb.$year$mon.avrg.grib || exit 8
	  ${FORCE_GRIB_DATE_MON} $outdir/pgb.$year$mon.avrg.grib $year${mon}0100 || exit 8
      else
	  echo pgb.$year$mon.avrg.grib exists
      fi
    done
    year=`expr $year + 1`
done
