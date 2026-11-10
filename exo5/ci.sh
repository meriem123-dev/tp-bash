#!/bin/bash

set -Eeuo pipefail

#verif argument
if [ -z "${1:-}" ]; then
   echo "Erreur : veuillez fournir l'url du depot git : "
   echo "utilisation : ./ci.sh <url_du depot_"
   exit 1
fi

repo_url="$1"

#chemins
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$script_dir/projet"
log_file="$script_dir/ci.log"

#journaliser
log(){
   echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a  "$log_file"
}

#recup code
update_repo(){
log "recupération du depot..."
if [ -d "$project_dir/.git" ]; then 
     log "le depot existe : mise à jour avec git pull"
     if git -C "$project_dir" pull; then
        log "mise à jour réussie"
    else
        log "echec du git pull"
        return 1
    fi
else
    log "clonage du depot"
    if git clone "$repo_url" "$project_dir"; then
      log "clonage réussi"
    else
      log "echec du clonage"
      return 1
    fi
fi
}

#tests

run_tests() {
   log "début des tests..."
   if [ -f "$project_dir/package.json" ]; then
        if ( cd "$project_dir" && npm test); then
             log "tests réussis"
        else
             log "tests échoués"
             return 1
        fi
   else
       log "aucun framework de tests configuré"
       log "tests simulés réussi"
   fi

}


#exec pipeline
log "**début du pipeline CI**"
if update_repo && run_tests; then 
   log "pipeline réussi"
   exit 0
else
   log "pipeline échoué"
   exit 1
fi




