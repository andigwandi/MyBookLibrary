param (
    [string]$key = ""
)

function Get-AzureMetadata {
    $metadataUrl = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
    
    if ([string]::IsNullOrEmpty($key)) {
        $metadata = Invoke-RestMethod -Uri $metadataUrl -Headers @{ "Metadata" = "true" }
    }
    else {
        $metadata = Invoke-RestMethod -Uri $metadataUrl -Headers @{ "Metadata" = "true" } | Select-Object -ExpandProperty $key
    }
    
    return $metadata
}

# Main script

# Fetch Azure Metadata without specifying a key
$metadata = Get-AzureMetadata
Write-Host "Azure Metadata:"
$metadata | Format-List

# Fetch Azure Metadata for a specific key
if (-not [string]::IsNullOrEmpty($key)) {
    $value = Get-AzureMetadata -key $key
    Write-Host "Value for key '$key': $value"
}