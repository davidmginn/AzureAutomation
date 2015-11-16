workflow ModuleAndVariables
{
	$BaseUrl = Get-AutomationVariable -Name "BaseUrl"
	$TopicName = Get-AutomationVariable -Name "TopicName"
	$Key = Get-AutomationVariable -Name "Key"
	$Secret = Get-AutomationVariable -Name "Secret"

	$Message = "Hello Cincinnati Azure User Group"

	New-AzureServiceBusMessage -baseUrl $BaseUrl -topicName $TopicName -secret $Secret -key $Key -body $Message
}
