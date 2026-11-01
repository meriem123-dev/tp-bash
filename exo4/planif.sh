#!/bin/bash
DOSSIER="$HOME/Documents/5GL/DevOps/tp-bash/exo4"
SCRIPT="$DOSSIER/backup.sh"
LOG="$DOSSIER/backup.log"

# Vérifier si backup.sh est déjà planifié
if crontab -l 2>/dev/null | grep -qF "$SCRIPT"; then
    echo "La tâche de sauvegarde est déjà planifiée."
else
    echo "Aucune tâche trouvée, ajout en cours..."

    (crontab -l 2>/dev/null
     echo "0 2 * * * $SCRIPT >> $LOG 2>&1") | crontab -

     echo "Tâche ajoutée : sauvegarde chaque nuit à 2h00."
fi

