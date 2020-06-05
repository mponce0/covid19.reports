## updateREPORTS.sh


################

updateFiles() {

	commitMsg="daily update of covid19 data/plots/figures: "$1" ... "`date`"-"`hostname`
	mv -v $BASEdir/$fig $RPROJECTSdir/man/figures	&&	\
	#mv -v $BASEdir/$fig $RPROJECTSdir/reports  &&      \
		cd $RPROJECTSdir		&&	\
		git add man/figures/$1		&&	\
	#	git add reports/$1		&&	\
		git commit -m "$commitMsg"	&&	\
		git push			&&	\
		cd $BASEdir
}

################

RSCRIPT=`which Rscript`

BASEdir="${HOME}/../mponce/projects/R-packages/covid19_updates"
RPROJECTSdir="${HOME}/../mponce/projects/R-packages/covid19.analytics"
#RPROJECTSdir="${HOME}/../mponce/projects/R-packages/covid19.reports"

LOGfile="cron_covid19.log"


#cd ${BASEdir}

touch $LOGfile

# stamp the date
date

# first call the Rscript to generate plots
$RSCRIPT  queryScript.R  2>&1  >  $LOGfile

## Convert report to PDF...
baseREPORTfile="covid19-SummaryReport"
reportFILE=${baseREPORTfile}"_"`date +"%Y-%m-%d"`".txt"
txtREPORTfile=${baseREPORTfile}".txt"
psREPORTfile=${baseREPORTfile}".ps"
### Generate PS -> PDF
a2psOPTS='-1  --landscape  --header="Produced with covid19.analytics R Package"'
echo $a2psOPTS
#a2ps  ${a2psOPTS}  ${reportFILE} -o ${psREPORTfile}
/usr/bin/a2ps -1 --chars-per-line=140  --landscape  --header="Produced with **covid19.analytics** R Package"  ${reportFILE} -o ${psREPORTfile}
/usr/bin/ps2pdf ${psREPORTfile}
echo $?
# clean-up
mv  -v  ${reportFILE} ${txtREPORTfile}
rm  -v  ${psREPORTfile} 
rm  -v  Rplots.pdf

## commit files...
targets="*html *pdf "${txtREPORTfile}
for fig in ${targets}; do
	echo $fig;
	updateFiles $fig;
done
##


#################
