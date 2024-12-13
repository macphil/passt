[CultureInfo]::CurrentCulture = 'de-DE' 

(Get-Content ./some-values.json | ConvertFrom-Json)
| Select-Object -ExpandProperty values
| Where-Object { $_.isTci -eq $true }
| Select-Object -Property isTci,
@{n = 'approvedAmount'; e = { '{0:N2} {1}' -f $_.approvedAmount, $_.currency.localizedName } },
@{
    Name       = 'lName' 
    Expression = { 
        $_.limitTypeIdentifier.localizedNames.
        Where({ $_.language -eq 'de' }).
        localizedName 
    } 
}
| Format-List