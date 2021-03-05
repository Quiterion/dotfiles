#!/bin/bash

for i in $(find /home/quiterion/Uni/ -maxdepth 2 -type f -name "*.tex"); do
	texclear $i
done
