FROM mcr.microsoft.com/azure-cli AS base

RUN az --version

RUN az login --service-principal -u $APP_ID -p $APP_PASSWORD --tenant $APP_TENANT_ID

RUN ACI_IP=$(az container show --name $ACI_INSTANCE_NAME --resource-group $RESOURCE_GROUP --query ipAddress.ip --output tsv)

RUN az network private-dns record-set a update --name $A_RECORD_NAME --resource-group $RESOURCE_GROUP --zone-name $DNS_ZONE_NAME --set aRecords[0].ipv4Address=$ACI_IP

