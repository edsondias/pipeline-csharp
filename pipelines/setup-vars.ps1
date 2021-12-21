$prjDevops="VSPlataforma"
az devops configure --defaults project=$prjDevops organization=$env:AZURE_DEVOPS_ORG
$varlist=(az pipelines variable-group list  --query "[?starts_with(name, 'function-csharp-')].id" -o tsv)

foreach ($item in $varlist) {
    az pipelines variable-group delete --id $item --yes
}
    
$repo="function-csharp"
$enviroments = $("tu", "ti", "th", "pr")

#ajustar variáveis necessárias para o deploy da function abaixo
foreach ($e in $enviroments) {
    az pipelines variable-group create --authorize true --name $repo-$e --variables `
            appName="azu-func-"$e-"devops" `
            slotName=""  `
            resourceGroupName="" 
}

