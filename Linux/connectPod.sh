#!/bin/sh

#
# Connect to Google Cloud Kubernetes Pods
# HIPAA VAULT
# Date: 11/04/2025


# === Step 1: Read customer alias from user input ===
echo -n "Enter customer alias name: "
read aliasName

# Validate input
if [ -z "$aliasName" ]; then
  echo "Error: Customer alias cannot be empty."
  exit 1
fi

echo "Searching for pod matching alias: '$aliasName'..."

# === Step 2: Search for pod using aliasName (case-insensitive, partial match) ===
# Uses kubectl + grep + awk to extract the first matching pod name
podName=$(kubectl get pods --all-namespaces --no-headers 2>/dev/null | \
          grep -i "$aliasName" | \
          head -n1 | \
          awk '{print $2 "/" $1}')

# Check if pod was found
if [ -z "$podName" ]; then
  echo "Error: No pod found matching alias '$aliasName'."
  echo "Tip: Try a partial name or check spelling."
  exit 1
fi

# Extract namespace and pod name
NAMESPACE=$(echo "$podName" | cut -d'/' -f1)
POD=$(echo "$podName" | cut -d'/' -f2)

echo "Found pod: $POD in namespace: $NAMESPACE"

# === Step 3: Login to the pod using kubectl exec ===
echo "Logging into pod '$POD'..."
kubectl exec -it $NAMESPACE -- /bin/sh
