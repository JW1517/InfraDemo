#!/bin/bash

# Projet GCP
PROJECT="infrademo-472206"
ZONE="europe-west1-b"

echo "🔹 Projet actif : $PROJECT"

# 1️⃣ Stopper toutes les VM
echo "⏹ Arrêt des VM..."
gcloud compute instances list --project="$PROJECT" --zones="$ZONE" --format="value(name)" | while read VM; do
  echo "  - Arrêt de la VM : $VM"
  gcloud compute instances stop "$VM" --zone="$ZONE" --quiet
done

# 2️⃣ Vérifier les IP externes
echo "🌐 Vérification des IP externes éphémères..."
gcloud compute addresses list --project="$PROJECT" --format="table(name, address, status, purpose, users)"

# 3️⃣ Résumé
echo "✅ Toutes les VM du projet '$PROJECT' ont été arrêtées."
echo "💡 Vérifie les IP listées ci-dessus pour t'assurer qu'il n'y a rien de payant."
echo "Tu peux maintenant fermer ton terminal en toute sécurité."
