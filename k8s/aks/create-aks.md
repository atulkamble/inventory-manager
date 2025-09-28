Got it 👍 I’ll make sure the script **explicitly includes the `az group create` command** so it’s clear how the resource group `aks` is created.

Here’s the updated script:

```bash
#!/usr/bin/env bash
set -euo pipefail

# ===== Config (edit here) =====
SUBSCRIPTION_ID="50818730-e898-4bc4-bc35-d998af53d719"
LOCATION="centralindia"
AKS_RG_NAME="aks"                          # Resource Group name
AKS_NAME="mycluster"                       # AKS Cluster name
NODE_COUNT=2
NODE_SIZE="Standard_B2s"

# ===== Pre-req checks =====
command -v az >/dev/null 2>&1 || { echo "Azure CLI not found"; exit 1; }
command -v kubectl >/dev/null 2>&1 || az aks install-cli

echo "Logging into Azure..."
az account show >/dev/null 2>&1 || az login --use-device-code

# ===== Set subscription =====
echo "Setting subscription to ${SUBSCRIPTION_ID} ..."
az account set --subscription "${SUBSCRIPTION_ID}"

# ===== Create Resource Group =====
echo "Creating resource group: ${AKS_RG_NAME} in ${LOCATION} ..."
az group create \
  --name "${AKS_RG_NAME}" \
  --location "${LOCATION}"

# ===== Create AKS Cluster =====
if ! az aks show -g "${AKS_RG_NAME}" -n "${AKS_NAME}" >/dev/null 2>&1; then
  echo "Creating AKS cluster ${AKS_NAME} ..."
  az aks create \
    --resource-group "${AKS_RG_NAME}" \
    --name "${AKS_NAME}" \
    --enable-managed-identity \
    --node-count "${NODE_COUNT}" \
    --node-vm-size "${NODE_SIZE}" \
    --generate-ssh-keys
else
  echo "AKS cluster ${AKS_NAME} already exists."
fi

# ===== Get credentials & test =====
echo "Fetching kubeconfig and testing access ..."
az aks get-credentials -g "${AKS_RG_NAME}" -n "${AKS_NAME}" --overwrite-existing
kubectl get nodes -o wide
```

---

🔹 Now the script **always creates** the resource group `aks` first with:

```bash
az group create --name aks --location centralindia
```

Do you also want me to add a **separate one-liner** at the top (outside the script) so you can quickly create the `aks` resource group before running the rest of the script?
