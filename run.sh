#!/bin/bash

rm -rf 20*

linux_bzt_loc=/opt/rh/rh-python36/root/usr/bin/bzt
if [[ -f "$linux_bzt_loc" ]]; then
	bzt=$linux_bzt_loc
else
	bzt="bzt"
fi

if [[ $# -eq 0 ]] ; then
    echo "No Branch Argument passed"
    branch_text=""
else
	echo "Branch Argument is $1"
	branch_text=" - Branch:$1"
fi

for d in */ ; do
        echo "### Looping through $d ###"
		chmod 755 -R $d
        for filename in $d/*; do
				mod_file_str=`echo ${filename##*/}`
				mod_file_str=`echo ${mod_file_str%%.*}`
				if [[ $filename =~ \.jmx$ ]]; then
						echo "Executing ${filename/\//} as a functional test with name '${mod_file_str} Functional Test'"
                        ${bzt} ${filename/\//} -cloud -func -detach -o modules.blazemeter.test="${mod_file_str} Functional Test" -o modules.blazemeter.report-name="${mod_file_str} Functional Test Report${branch_text}"
				elif [[ $filename =~ \.yml$ ]]; then
						echo "Executing ${filename/\//} as a performance test with name '${mod_file_str} Load Test'" 
                        ${bzt} ${filename/\//} -cloud -detach -o modules.blazemeter.test="${mod_file_str}" -o modules.blazemeter.report-name="${mod_file_str} Report${branch_text}"
                fi
        done
		echo "### Finished Looping through $d ###"
done
