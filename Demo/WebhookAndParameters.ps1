workflow WebhookWithParametersDemo
{
	param (
		[string]$Name,
		[string]$ServiceName,
    [object]$WebhookData
    )

    if ($WebhookData -ne $null) {

        $WebhookName    =   $WebhookData.WebhookName
        $WebhookBody    =   $WebhookData.RequestBody
        $WebhookHeaders =   $WebhookData.RequestHeader

        $WebhookBody = (ConvertFrom-Json -InputObject $WebhookBody)

		$Name = $WebhookBody.VMName
		$ServiceName = $WebhookBody.ServiceName
	}

	Write-Output $Name

	Write-Output $ServiceName
}
