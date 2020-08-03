#!/bin/bash
rm -rf 20*
linux_bzt_loc=/opt/rh/rh-python36/root/usr/bin/bzt
if [[ -f "$linux_bzt_loc" ]]; then
	bzt=$linux_bzt_loc
else
	bzt="bzt"
fi

for d in */ ; do
        echo "Looping through $d"
		chmod 755 -R $d
        for filename in $d/*; do
				mod_file_str=`echo ${filename##*/}`
				mod_file_str=`echo ${mod_file_str%%.*}`
				if [[ $filename =~ \.jmx$ ]]; then
						echo "Executing ${filename/\//} as a functional test with name '${mod_file_str} Functional Test'"
                        ${bzt} ${filename/\//} -cloud -func -detach -o modules.blazemeter.test="${mod_file_str} Functional Test" -o modules.blazemeter.report-name="${mod_file_str} Functional Report"
				elif [[ $filename =~ \.yml$ ]]; then
						echo "Executing ${filename/\//} as a performance test"
                        ${bzt} ${filename/\//} -cloud -detach
                fi
        done
done
