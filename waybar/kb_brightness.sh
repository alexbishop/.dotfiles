#!/bin/sh

case "$(cat /sys/class/leds/tpacpi::kbd_backlight/brightness)" in
  1)
    echo '{ "text": " " }'
    ;;
  2)
    echo '{ "text": " ", "class": "solid" }'
    ;;
  *)
    echo '{ "text": "" }'
    ;;
esac
