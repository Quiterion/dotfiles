#!/usr/bin/env bash

i3-msg -t subscribe -m '[ "window", "binding" ]' | while read line; do
    layout=$(i3-msg -t get_tree | jq 'recurse(.nodes[]) | select(.nodes[].focused? == true) | .layout')
    case $layout in
        '"splith"')
            echo "";;
        '"splitv"')
            echo "";;
        '"tabbed"')
            echo "󰓩";;
        '"stacked"')
            echo "";;
            *)
            echo "";;
    esac;
done
