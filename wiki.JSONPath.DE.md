:de: JSONPath


| Beschreibung                 | JSONPath                                                     | Ergebnis |
| :--------------------------- | :----------------------------------------------------------- | :------- |
| Anzahl Array-Elemente        | `$.values.**length**`                                        | 2        |
| erste Element                | `$.values[**0**].approvedAmount`                             | 2000     |
| letze Element                | `$.values[**-1:**].approvedAmount`                           | 7500     |
| Element mit bool - condition | `$.values[**?(@.isTci)**].approvedAmount`                    | 2000     |
| Element mit text-vergleich   | `$.values[**?(@.limitTypeIdentifier.identifier == 'Limitvorschlag')**].approvedAmount` | 7500     |
| Element mit Null-Vergleich   | `$.values[**?(@.decisivenessRank == null)**].approvedAmount` | 2000     |


Gegeben sei folgendes JSON:
```json
{
    "values": [
        {
            "approvedAmount": 2000.0000,
            "currency": {
                "localizedName": "EUR",
                "numericValue": 978,
                "value": "EUR"
            },
            "debtorId": "f5b06df1-b4d9-44af-85fe-aa2bb99a9a36",
            "decisivenessRank": null,
            "id": "8e41b3f5-127b-486a-8903-6fd2bc30c372",
            "isTci": true,
            "limitTypeId": "2540be5e-d416-49e0-9547-c17365ba7952",
            "limitTypeIdentifier": {
                "identifier": "WKV-Limit",
                "localizedName": "TCI limit (en)"
            },
            "state": {
                "localizedName": "Aktiv",
                "numericValue": 1,
                "value": "Active"
            },
            "validFrom": "2018-10-25T00:00:00",
            "validTo": "9999-12-31T23:59:59"
        },
        {
            "approvedAmount": 7500.0000,
            "currency": {
                "localizedName": "EUR",
                "numericValue": 978,
                "value": "EUR"
            },
            "debtorId": "ee1a5952-8a8b-4a63-9ba7-c96456307606",
            "decisivenessRank": 1,
            "id": "da52efff-4f2c-4d22-9f04-8bb420fb0e3f",
            "isTci": false,
            "limitTypeId": "5933ad8d-400e-4b5d-ad05-18c7175e981e",
            "limitTypeIdentifier": {
                "identifier": "Limitvorschlag",
                "localizedName": "Limit proposal"
            },
            "state": {
                "localizedName": "Aktiv",
                "numericValue": 1,
                "value": "Active"
            },
            "validFrom": "2018-10-25T00:00:00",
            "validTo": "9999-12-31T23:59:59"
        }
    ]
}
```
