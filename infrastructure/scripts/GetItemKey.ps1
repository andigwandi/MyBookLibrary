function Get-NestedValue {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [object]$Object,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Key
    )
    
    $keys = $Key -split '/'
    $value = $Object
    
    foreach ($k in $keys) {
        if ($value -is [System.Collections.IDictionary] -and $value.ContainsKey($k)) {
            $value = $value[$k]
        }
        else {
            return $null
        }
    }
    
    return $value
}


$object1 = @{
    "a" = @{
        "b" = @{
            "c" = "d"
        }
    }
}
$key1 = "a/b/c"
$result1 = Get-NestedValue -Object $object1 -Key $key1

Write-Host "Data: $($object1 | ConvertTo-Json)"
Write-Host "Seach Key: $key1"
Write-Output "Result: $(if ($null -eq $result1) { "Key Not Found"} else {$($result1 | ConvertTo-Json)})" 
Write-Host "================="

$object2 = @{
    "x" = @{
        "y" = @{
            "z" = "a"
        }
    }
}
$key2 = "x/y"
$result2 = Get-NestedValue -Object $object2 -Key $key2

Write-Host "Data: $($object2 | ConvertTo-Json)"
Write-Host "Seach Key: $key2"
Write-Output "Result: $(if ($null -eq $result2) { "Key Not Found"} else {$($result2 | ConvertTo-Json)})" 


Write-Host "================="

$object3 = @{
    "x" = @{
        "y" = @{
            "z" = "a"
        }
    }
}
$key3 = "6"
$result3 = Get-NestedValue -Object $object3 -Key $key3

Write-Host "Data: $($object3 | ConvertTo-Json)"
Write-Host "Seach Key: $key3"
Write-Output "Result: $(if ($null -eq $result3) { "Key Not Found"} else {$($result3 | ConvertTo-Json)})" 
