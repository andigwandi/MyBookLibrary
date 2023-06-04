param (
    [string]$key = ""
)

function Get-AzureMetadata {
    
    param(
        [string] $key
    )

    $respraw = Invoke-WebRequest -Headers @{"Metadata" = "true" } -Method GET -Proxy $Null -Uri "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
    $metadata = $respraw.Content

    return $metadata
}

function Get-KeyValues($json, $key) {
    $obj = $json | ConvertFrom-Json
    if ($obj.PSObject.Properties.Name -contains $key) {
        $keyVal = $obj.$key
        return $keyVal
    } else {
        Write-Host "Key '$key' not found in the JSON."
        return $null  # or return any default value as needed
    }


    return $keyVal
}

# Main script

# Fetch Azure Metadata without specifying a key

$metadata = Get-AzureMetadata
Write-Host "Azure Metadata:"
$metadata | Format-List

# Fetch Azure Metadata for a specific key
if (-not [string]::IsNullOrEmpty($key)) {
    $value = Get-KeyValues -json $metadata -key $key
    Write-Host "Value for key '$key': $value"
}