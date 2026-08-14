$bytes = [System.IO.File]::ReadAllBytes('C:\Users\andre\Downloads\Email.pdf')

# Check JPEG headers (0xFF, 0xD8, 0xFF)
for ($i = 0; $i -lt $bytes.Length - 4; $i++) {
    if ($bytes[$i] -eq 0xFF -and $bytes[$i+1] -eq 0xD8 -and $bytes[$i+2] -eq 0xFF) {
        for ($j = $i + 4; $j -lt $bytes.Length - 2; $j++) {
            if ($bytes[$j] -eq 0xFF -and $bytes[$j+1] -eq 0xD9) {
                $len = $j + 2 - $i
                if ($len -gt 50000) {
                    $imgBytes = New-Object byte[] $len
                    [Array]::Copy($bytes, $i, $imgBytes, 0, $len)
                    [System.IO.File]::WriteAllBytes('C:\Users\andre\Desktop\Work\portfolio-andre-main\images\email_agency_cover.png', $imgBytes)
                    Write-Host "EXTRACTED_JPEG_$len"
                    exit 0
                }
            }
        }
    }
}

# Check PNG headers (0x89, 0x50, 0x4E, 0x47)
for ($i = 0; $i -lt $bytes.Length - 4; $i++) {
    if ($bytes[$i] -eq 0x89 -and $bytes[$i+1] -eq 0x50 -and $bytes[$i+2] -eq 0x4E -and $bytes[$i+3] -eq 0x47) {
        for ($j = $i + 4; $j -lt $bytes.Length - 8; $j++) {
            if ($bytes[$j] -eq 0x49 -and $bytes[$j+1] -eq 0x45 -and $bytes[$j+2] -eq 0x4E -and $bytes[$j+3] -eq 0x44) {
                $len = $j + 8 - $i
                if ($len -gt 50000) {
                    $imgBytes = New-Object byte[] $len
                    [Array]::Copy($bytes, $i, $imgBytes, 0, $len)
                    [System.IO.File]::WriteAllBytes('C:\Users\andre\Desktop\Work\portfolio-andre-main\images\email_agency_cover.png', $imgBytes)
                    Write-Host "EXTRACTED_PNG_$len"
                    exit 0
                }
            }
        }
    }
}

Write-Host "NOT_FOUND_PLAIN_IMAGE"
