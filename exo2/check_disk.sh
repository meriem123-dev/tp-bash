#!/bin/bash
seuil=${1:-80} 
utilisation=$(df /mnt/c | awk 'NR==2 {print $5}' | tr -d '%')
echo "$utilisation"
if [ "$utilisation" -ge "$seuil" ]; then
echo "alerte : espace disque utilisé  dépasse ${seuil}"
exit 1
else
echo "espace suffisant"
exit 0
fi 

