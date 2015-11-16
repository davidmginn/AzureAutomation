Function New-AzureServiceBusMessage
{
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0, valueFromPipeline = $true)]
    $baseUrl,

    [Parameter(Mandatory = $true, Position = 1, valueFromPipeline = $true)]
    $topicName, 

    [Parameter(Mandatory = $true, Position = 2, valueFromPipeline = $true)]
    $secret,

    [Parameter(Mandatory = $true, Position = 3, valueFromPipeline = $true)]
    $key,
    
    [Parameter(Mandatory = $true, Position = 4, valueFromPipeline = $true)]
    $body,

    [Parameter(Mandatory = $false)]
    $customHeaderValues
)

$url = "{0}/{1}" -f $baseUrl, $topicName

$encodedUrl = [uri]::EscapeDataString($url)

$startDate = [datetime]"1/1/1970"

$endDate = Get-Date
$endDate = $endDate.ToUniversalTime()

$time = [int32](New-TimeSpan -Start $startDate -End $endDate).TotalSeconds + 3600

#signature

$message = "{0}`n{1}" -f $encodedUrl, $time

$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Text.Encoding]::UTF8.GetBytes($secret)
$signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($message))
$signature = [Convert]::ToBase64String($signature)

$encodedSignature = [uri]::EscapeDataString($signature)

$sas = "SharedAccessSignature sr={0}&sig={1}&se={2}&skn={3}" -f $encodedUrl, $encodedSignature, $time, $key

$headers = @{ 'Authorization' = $sas }

if($customHeaderValues -is [hashtable]){
    ([hashtable]$customHeaderValues).GetEnumerator() | % { $headers.Add($_.Key, $_.Value)}
}

$webRequestUri = "{0}/messages" -f $url

$response = Invoke-WebRequest -Uri $webRequestUri -Method POST -Headers $headers -UseBasicParsing -Body $body

}
