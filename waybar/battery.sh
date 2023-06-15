#!/usr/bin/sh

THRESHOLD=50

NOT_CHARGING=0
TOTAL_CAPACITY=0.0
CURRENT_CAPACITY=0.0
POWER=$(ls /sys/class/power_supply | grep "AC")
POWERSUPPLY="/sys/class/power_supply/$POWER/online"
STATUS=$(cat $POWERSUPPLY)

mapfile -t BATTERY_PATHS < <(upower -e | grep battery)

# Calculate the total and current capacity of all batteries
for BATTERY_PATH in "${BATTERY_PATHS[@]}"; do
    BATTERY_PERCENTAGE=$(upower -i "$BATTERY_PATH" | grep percentage | awk '{print $2}' | sed 's/%//')
    total_capacity=$(upower -i $BATTERY_PATH | grep "energy-full:" | awk '{print $2}')
    TOTAL_CAPACITY=$(echo "$TOTAL_CAPACITY + $total_capacity" | bc)
    current_capacity=$(upower -i $BATTERY_PATH | grep "energy:" | awk '{print $2}')
    CURRENT_CAPACITY=$(echo "$CURRENT_CAPACITY + $current_capacity" | bc)
done

# Calculate the current percentage and round to whole number
CURRENT_PERCENTAGE=$(echo $CURRENT_CAPACITY/$TOTAL_CAPACITY*100 | bc -l | cut -d "." -f 1)

if [ "$CURRENT_PERCENTAGE" -lt $THRESHOLD -a $STATUS = $NOT_CHARGING ]; then
    zenity \
      --info \
      --title "Low battery warning" \
      --text "Current capacity at $CURRENT_PERCENTAGE%"
fi
