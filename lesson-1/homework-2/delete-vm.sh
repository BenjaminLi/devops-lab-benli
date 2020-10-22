
# Clean up
az vm delete -y --ids $(az vm list -g myResourceGroup --query "[].id" -o tsv)

az disk delete -y --ids $(az disk list -g myResourceGroup --query "[].id" -o tsv)
for i in networkInterfaces publicIPAddresses networkSecurityGroups virtualNetworks
do
az resource delete --ids $(az resource list --query "[?type=='Microsoft.Network/${i}'].id" -o tsv)
done

az keyvault delete --name BenKeys

az deployment group delete --resource-group myResourceGroup -n myResourceGroup

