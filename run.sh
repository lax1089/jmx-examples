#!/bin/bash
rm -rf 20*
bzt = opt/rh/rh-python36/root/usr/bin/bzt

for d in */ ; do
        echo "Looping through $d"
        for filename in $d/*; do
                if [[ $filename =~ \.yml$ ]]; then
                        echo "Executing ${filename/\//}"
                        ${bzt} ${filename/\//} -cloud -func
                fi
        done
done
