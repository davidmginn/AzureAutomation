workflow WebhookDemo
{
	param (
        [object]$WebhookData
    )

    # If runbook was called from Webhook, WebhookData will not be null.
    if ($WebhookData -ne $null) {
        # Collect properties of WebhookData.
        $WebhookName    =   $WebhookData.WebhookName
        $WebhookBody    =   $WebhookData.RequestBody
        $WebhookHeaders =   $WebhookData.RequestHeader

        # Obtain the WebhookBody containing the AlertContext
        $WebhookBody = (ConvertFrom-Json -InputObject $WebhookBody)

		Write-Output $WebhookBody
	}
}
