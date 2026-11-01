set -Eeuo pipefail
DOSSIER="dossier"
DATE=$(date +%Y-%m-%d_%H-%M-%S )
DESTINATION="./backup"
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

if [ ! -d "$DOSSIER" ]; then
echo "erreur : le dossier `$DOSSIER` n'existe pas"
exit 1
fi
mkdir -p "$DESTINATION"

tar -czf "$ARCHIVE" "$DOSSIER"
echo "sauvegarde crée"

for fic in "$DESTINATION/"*.tar.gz; do
[ -e "$fic" ] || continue
if [ "$(find "$fic" -maxdepth 0 -mtime +7 -print)" ]; then
rm -- "$fic"
echo "ancienne sauvegarde supprimée"
fi

done
echo "sauvegarde terminée"
