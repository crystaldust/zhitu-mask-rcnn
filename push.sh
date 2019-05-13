#!/bin/bash

# TODO, clear all outputs by calling Jupyter notebook API, in stead of checking the output

IFS=$'\n'

outputs=($(grep -nri 'outputs":' ./*.ipynb --exclude=instance_segmentation_with_mask_rcnn.ipynb))
for output in ${outputs[@]}
do
	last_item=$(echo $output | awk '{print $NF}')
	if [ "$last_item" != "[]," ]; then
		first_item=$(echo $output | awk '{print $1}')
		echo "ERROR!" $first_item "output not cleared"
		exit 1
	fi
done

echo "all outputs are cleared, let's push!"
git push
