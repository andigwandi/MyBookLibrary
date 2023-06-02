param (
    [string]$key = ""
)

function Get-AzureMetadata {
    
    param(
        [string] $key
    )

    $respraw = Invoke-WebRequest -Headers @{"Metadata" = "true" } -Method GET -Proxy $Null -Uri "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
    
    if ([string]::IsNullOrEmpty($key)) {
        $metadata = $respraw.Content | ConvertFrom-Json | ConvertTo-Json -Depth 6
    }
    else {
        $metadata = $respraw.Content | Select-Object -ExpandProperty $key |  ConvertFrom-Json | ConvertTo-Json -Depth 6 
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