#!/bin/bash

layout=$(i3-msg -t get_tree | jq 'recurse(.nodes[]) | select(.nodes[].focused? == true) | .layout')

case $layout in
	'"splith"')
		echo "";;
	'"splitv"')
		echo "";;
	'"tabbed"')
		echo "";;
	'"stacked"')
		echo "";;
esac
