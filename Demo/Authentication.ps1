workflow Demo
{
	$cred = Get-AutomationPSCredential -Name "AutomationDemo"

	Add-AzureAccount -Credential $cred
	Select-AzureSubscription -subscriptionName "Visual Studio Premium with MSDN"

	$vm = Get-AzureVM -Name DGinnDemoVM -ServiceName DGinnDemoVM

	Write-Output $vm

	Start-AzureVM -Name DGinnDemoVM -ServiceName DGinnDemoVM

	Start-AzureWebsite -Name AzureAutomationDemo
}
