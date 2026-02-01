<#
.SYNOPSIS
Displays a formatted table of character codes and their representations.

.DESCRIPTION
Prints rows of character information (decimal, hex, binary and a printable name/glyph)
for a contiguous range of Unicode code points. Output is ANSI-colored for terminals
that support escape sequences.

.PARAMETER FirstCode
Starting code point (decimal) to display. Must be >= 0. Default: 0.

.PARAMETER NumberOfChars
Number of code points to display. Must be >= 1. Default: 128.

.PARAMETER CharsPerRow
Number of characters shown per row (columns). Valid range: 1 to 24. Default: 16.

.EXAMPLE
.\Show-Chars.ps1 -FirstCode 32 -NumberOfChars 96 -CharsPerRow 16
Displays printable ASCII characters from 32 to 127 in a 16-column table.

.NOTES
Designed for use in ANSI-capable consoles.
#>

[CmdletBinding()]
param (
    [Parameter()]
    [ValidateRange(0, [int]::MaxValue)]
    [int] $FirstCode = 0,
    [ValidateRange(1, [int]::MaxValue)]
    [int] $NumberOfChars = 128,
    [ValidateRange(1, 24)]
    [int] $CharsPerRow = 16
)

begin {
    function GetChar {
        param (
            [int] $code
        )
        switch ($code) {
            0	{ return 'NUL' }            # 0 { return '␀' }
            1	{ return 'SOH' }            # 1 { return '␁' }
            2	{ return 'STX' }            # 2 { return '␂' }
            3	{ return 'ETX' }            # 3 { return '␃' }
            4	{ return 'EOT' }            # 4 { return '␄' }
            5	{ return 'ENQ' }            # 5 { return '␅' }
            6	{ return 'ACK' }            # 6 { return '␆' }
            7	{ return 'BEL' }            # 7 { return '␇' }
            8	{ return 'BS' }             # 8 { return '␈' }
            9	{ return 'HT' }             # 9 { return '␉' }
            10	{ return 'LF' }             # 10 { return '␊' }
            11	{ return 'VT' }             # 11 { return '␋' }
            12	{ return 'FF' }             # 12 { return '␌' }
            13	{ return 'CR' }             # 13 { return '␍' }
            14	{ return 'SO' }             # 14 { return '␎' }
            15	{ return 'SI' }             # 15 { return '␏' }
            16	{ return 'DLE' }            # 16 { return '␐' }
            17	{ return 'DC1' }            # 17 { return '␑' }
            18	{ return 'DC2' }            # 18 { return '␒' }
            19	{ return 'DC3' }            # 19 { return '␓' }
            20	{ return 'DC4' }            # 20 { return '␔' }
            21	{ return 'NAK' }            # 21 { return '␕' }
            22	{ return 'SYN' }            # 22 { return '␖' }
            23	{ return 'ETB' }            # 23 { return '␗' }
            24	{ return 'CAN' }            # 24 { return '␘' }
            25	{ return 'EM' }             # 25 { return '␙' }
            26	{ return 'SUB' }            # 26 { return '␚' }
            27	{ return 'ESC' }            # 27 { return '␛' }
            28	{ return 'FS' }             # 28 { return '␜' }
            29	{ return 'GS' }             # 29 { return '␝' }
            30	{ return 'RS' }             # 30 { return '␞' }
            31	{ return 'US' }             # 31 { return '␟' }
            127	{ return 'DEL' }            # 127 { return '␡' }
            default { return [char]($charDec) }
        }
    }
}

process {
    $fcColor = "`e[38;5;241m"
    for ($i = $FirstCode; $i -lt ($FirstCode + $NumberOfChars); $i = $i + $CharsPerRow) {
        $decRow = $hexRow = $charRow = $binRow = ''
        for ($column = 0; $column -lt $CharsPerRow; $column++) {
            $charDec = ($i + $column)
            $decRow += ('│   {0,6} │' -f $charDec)
            $hexRow += ('│   0x{0:x4} │' -f $charDec)
            $binRow += ('│ {0} │' -f ($charDec -lt 256 ? ([Convert]::ToString($charDec, 2)).PadLeft(8, '0') : ' ' * 8) )
            $charRow += ("│  `e[32m{0,4}    $fcColor│" -f (GetChar -code $charDec))

        }
        Write-Host $fcColor ('┌──────────┐' * $CharsPerRow)
        Write-Host $fcColor ($decRow)
        Write-Host $fcColor ($hexRow)
        Write-Host $fcColor ($binRow)
        Write-Host $fcColor ('├──────────┤' * $CharsPerRow )
        Write-Host $fcColor ($charRow)
        Write-Host $fcColor ('└──────────┘' * $CharsPerRow )
    }
}

end {

}