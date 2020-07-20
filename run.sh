#!/bin/bash
rm -rf 20*
bzt=/opt/rh/rh-python36/root/usr/bin/bzt

for d in */ ; do
        echo "Looping through $d"
		chmod 755 -R $d
        for filename in $d/*; do
                if [[ $filename =~ \.yml$ ]]; then
                        echo "Executing ${filename/\//} as a functional test"
                        ${bzt} ${filename/\//} -cloud -func
			echo "Executing ${filename/\//} as a performance test"
                        ${bzt} ${filename/\//} -cloud -detach
                fi
        done
done
