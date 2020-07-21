#!/bin/bash
rm -rf 20*
bzt=/opt/rh/rh-python36/root/usr/bin/bzt

for d in */ ; do
        echo "Looping through $d"
		chmod 755 -R $d
        for filename in $d/*; do
                if [[ $filename =~ \.yml$ ]]; then
						mod_file_str=`echo ${filename##*/}`
						mod_file_str=`echo ${mod_file_str%%.*}`
                        echo "Executing ${filename/\//} as a functional test with name '${mod_file_str} Functional Test'"
                        ${bzt} ${filename/\//} -cloud -func -o modules.blazemeter.test="${mod_file_str} Functional Test" -o modules.blazemeter.report-name="${mod_file_str} Functional Report"
						echo "Executing ${filename/\//} as a performance test"
                        #${bzt} ${filename/\//} -cloud -detach
                fi
        done
done
