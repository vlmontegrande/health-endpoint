#!/bin/sh

get_cpu_usage() {
  top -bn1 | head -n 5 | awk '/%Cpu/ {print 100 - $8"%"}'
}

get_memory_usage() {
  memory= free -m | awk 'NR==2{printf "%s/%s", $3,$2}'
}

get_disk_usage() {
  #df -m --total | awk 'END{print "Used: "$3", Free: "$4", Usage: "$5"\n"}'
  df -m --total | awk 'END{printf "%s/%s", $3,$2}'
}

get_uptime() {
  uptime -s
}

get_users() {
  who | awk '{print $1}'
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
