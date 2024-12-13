# :de: JSONPath

| Beschreibung                 | JSONPath                                                                               | Ergebnis |
| :--------------------------- | :------------------------------------------------------------------------------------- | :------- |
| Anzahl Array-Elemente        | `$.values.**length**`                                                                  | 2        |
| erste Element                | `$.values[**0**].approvedAmount`                                                       | 2000     |
| letze Element                | `$.values[**-1:**].approvedAmount`                                                     | 7500     |
| Element mit bool - condition | `$.values[**?(@.isTci)**].approvedAmount`                                              | 2000     |
| Element mit text-vergleich   | `$.values[**?(@.limitTypeIdentifier.identifier == 'limit-proposal')**].approvedAmount` | 7500     |
| Element mit Null-Vergleich   | `$.values[**?(@.decisivenessRank == null)**].approvedAmount`                           | 2000     |

Gegeben sei folgendes JSON:

```json
{
  "values": [
    {
      "approvedAmount": 2000.0,
      "currency": {
        "localizedName": "EUR",
        "numericValue": 978,
        "value": "EUR"
      },
      "isTci": true,
      "limitTypeIdentifier": {
        "identifier": "tci-limit",
        "localizedNames": [
          {
            "language": "de",
            "localizedName": "WKV Limit (de)"
          },
          {
            "language": "en",
            "localizedName": "TCI limit (en)"
          }
        ]
      },
      "validFrom": "2018-10-25T00:00:00",
      "validTo": "9999-12-31T23:59:59"
    },
    {
      "approvedAmount": 7500.0,
      "currency": {
        "localizedName": "EUR",
        "numericValue": 978,
        "value": "EUR"
      },
      "isTci": false,
      "limitTypeIdentifier": {
        "identifier": "limit-proposal",
        "localizedNames": [
          {
            "language": "de",
            "localizedName": "Limit vorschlag (de)"
          },
          {
            "language": "en",
            "localizedName": "Limit proposal (en)"
          }
        ]
      },
      "validFrom": "2018-10-25T00:00:00",
      "validTo": "9999-12-31T23:59:59"
    }
  ]
}
```

Abfrage per PowerShell:

```powershell
[CultureInfo]::CurrentCulture = 'de-DE'

$json | Select-Object -ExpandProperty values
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

isTci          : True
approvedAmount : 2.000,00 EUR
lName          : WKV Limit (de)
```
