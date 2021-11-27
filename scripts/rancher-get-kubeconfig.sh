#!/bin/bash

set -e
set -o pipefail

if [[ -z "${RANCHER_TOKEN}" ]]; then
  echo "RANCHER_TOKEN required"
  exit 1
fi

if [[ -z "${RANCHER_URL}" ]]; then
  echo "RANCHER_URL required"
  exit 1
fi

config_path=${HOME}/k8s
auth_header="Authorization: Bearer ${RANCHER_TOKEN}"

echo "-- Create and permission config dir ${config_path}"
mkdir -p "${config_path}"
chmod 700 "${config_path}"

echo "-- Get list of all of your clusters."
clusters=$(curl -sSLf -H "${auth_header}" "${RANCHER_URL}/v3/clusters/" | jq -r '.data[].name')

for c in ${clusters}; do
  if [ "${c}" == "local" ]; then
    continue
  fi
  kubeconfig_url=$(curl -sSLf -H "${auth_header}" "${RANCHER_URL}/v3/clusters/?name=${c}" | jq -r .data[0].actions.generateKubeconfig)

  echo "-- Write kubeconfig for ${c}"
  curl -sSLf -H "${auth_header}" -X POST "${kubeconfig_url}" | jq -r .config > "${config_path}/${c}.yaml"
  chmod 600 "${config_path}/${c}.yaml"
done
