#!/bin/bash
set -Eeuo pipefail

DOSSIER="$HOME/Documents/5GL/DevOps/tp-bash/exo4/dossier"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
DESTINATION="$HOME/Documents/5GL/DevOps/tp-bash/exo4/backup"
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier $DOSSIER n'existe pas"
    exit 1
fi

mkdir -p "$DESTINATION"

tar -czf "$ARCHIVE" "$DOSSIER"
echo "Sauvegarde créée"

for fic in "$DESTINATION"/*.tar.gz; do
    [ -e "$fic" ] || continue

    if [ "$(find "$fic" -maxdepth 0 -mtime +7 -print)" ]; then
        rm -- "$fic"
        echo "Ancienne sauvegarde supprimée"
    fi
done

echo "Sauvegarde terminée"