export INPUT_RESOLUTION=t62k28
# SCN=/home/geovault-00/buenning/nudge2010/libs/etc/scnvrt
# SCN=/work/data-00/buenning/test09/libs/etc/scnvrt
SCN=/home/ccr-01/buenning/test07/libs/etc/scnvrt
# CHGR=/home/geovault-03/buenning/nudge2010/gsm_runs/runscr/chgr
# CHGR=/work/data-00/buenning/test10/gsm_runs/runscr/chgr
CHGR=/home/ccr-01/buenning/test08/gsm_runs/runscr/chgr
INDIR=/home/ccr-01/buenning/nomad3
OUTDIR=/home/ccr-01/buenning/nomad126
YEAR=2012
MONTHS="01 02 03 04 05 06 07 08 09 10 11 12"
# MONTHS="08 09 10 11 12"
DAY=1
TIMES="00 06 12 18"
STDAY=1
MONTH="01"

if [ $MONTH -eq "02" ] ; then
 EDDAY=28
fi
if [ $MONTH -eq "04" ] ; then
 EDDAY=30
fi
if [ $MONTH -eq "06" ] ; then
 EDDAY=30
fi
if [ $MONTH -eq "09" ] ; then
 EDDAY=30
fi
if [ $MONTH -eq "11" ] ; then
 EDDAY=30
fi
if [ $MONTH -eq "01" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "03" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "05" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "07" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "08" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "10" ] ; then
 EDDAY=31
fi
if [ $MONTH -eq "12" ] ; then
 EDDAY=31
fi
DAY=1
while [ ${DAY} -le ${EDDAY} ] ; do
if [ ${DAY} -lt 10 ] ; then
 DAY=0${DAY}
fi
for TIME in ${TIMES} ; do 
echo $YEAR $MONTH $DAY $TIME
INFILE=${INDIR}/base.${YEAR}${MONTH}${DAY}${TIME}
TMPBASE=tmp.base
OUTFILE=${OUTDIR}/base.${YEAR}${MONTH}${DAY}${TIME}
TMPFILE=tmp.sig
echo $OUTFILE
${SCN} gsm osu1 62:192:94:28 -1:-1:-1:-1:-1 bin:bin ${INFILE}:dummy ${TMPBASE}:dummy
${CHGR} ${TMPBASE} dummy ${OUTFILE} dummy osu1


done

DAY=`expr ${DAY} + 1`

done
echo HELLO
echo $MONTH
echo now all done
echo all done
