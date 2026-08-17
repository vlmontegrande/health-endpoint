#!/bin/sh

get_cpu_usage() {
  read -r _ u1 n1 s1 i1 _ < /proc/stat
  sleep 1
  read -r _ u2 n2 s2 i2 _ < /proc/stat
  total=$(( (u2+n2+s2+i2) - (u1+n1+s1+i1) ))
  idle=$(( i2 - i1 ))
  awk -v t="$total" -v i="$idle" 'BEGIN{printf "%.1f%%", 100*(t-i)/t}'
}

get_memory_usage() {
  free -m | awk 'NR==2{printf "%s/%s", $3,$2}'
}

get_disk_usage() {
  df -m /rootfs | awk 'END{printf "%s/%s", $3,$2}'
}

get_uptime() {
  uptime -s
}

get_users() {
  who /rootfs/run/utmp | awk '{print $1}'
}

cpu=$(get_cpu_usage)

memory=$(get_memory_usage)

disk=$(get_disk_usage)

uptime=$(get_uptime)

users=$(get_users)

echo '{
  "cpu": "'$cpu'",
  "memory": "'$memory'",
  "disk": "'$disk'",
  "uptime": "'$uptime'",
  "users": "'$users'"
}'
