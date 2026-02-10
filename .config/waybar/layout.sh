#!/usr/bin/env bash

swaymsg -t subscribe -m '[ "window", "binding" ]' | while read line; do
    layout=$(swaymsg -t get_tree | jq 'recurse(.nodes[]) | select(.nodes[].focused? == true) | .layout')
    case $layout in
    '"splith"')
        echo ""
        ;;
    '"splitv"')
        echo ""
        ;;
    '"tabbed"')
        echo "󰓩"
        ;;
    '"stacked"')
        echo ""
        ;;
    *)
        echo ""
        ;;
    esac
done
