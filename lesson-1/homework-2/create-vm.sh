# Create key vault
az keyvault create \
  --name BenKeys \
  --resource-group myResourceGroup \
  --location centralus \
  --enable-soft-delete  false \
  --enabled-for-template-deployment true

az keyvault secret set --vault-name BenKeys --name "AdminSshPubKey" --value "`cat ~/.ssh/id_rsa.pub`"

az keyvault secret set --vault-name BenKeys --name "AdminPass" --value `openssl rand -base64 16`|jq -r ".value"
# !!! write down the password from output !!!
# 775bkotK2wcxfkdHmyrRCA==

# update json files

az deployment group create \
  --resource-group myResourceGroup \
  --parameters @./azuredeploy.parameters.json \
  --template-file ./azuredeploy.json


ssh-keygen -f "/home/$(id -nu)/.ssh/known_hosts" -R "devops-lab-benli.centralus.cloudapp.azure.com"

ssh devops@devops-lab-benli.centralus.cloudapp.azure.com
