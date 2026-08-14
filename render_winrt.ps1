[Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime] | Out-Null

$async1 = [Windows.Storage.StorageFile]::GetFileFromPathAsync('C:\Users\andre\Downloads\Email.pdf')
while (-not $async1.IsCompleted) { Start-Sleep -Milliseconds 50 }
$file = $async1.GetResults()

$async2 = [Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($file)
while (-not $async2.IsCompleted) { Start-Sleep -Milliseconds 50 }
$pdfDoc = $async2.GetResults()

$page = $pdfDoc.GetPage(0)
$outStream = [System.IO.File]::Create('C:\Users\andre\Desktop\Work\portfolio-andre-main\images\email_horizen_pdf_cover.png')
$winStream = [Windows.Storage.Streams.StreamAdapterExtensions]::AsRandomAccessStream($outStream)

$async3 = $page.RenderToStreamAsync($winStream)
while (-not $async3.IsCompleted) { Start-Sleep -Milliseconds 50 }

$outStream.Close()
Write-Host "WINRT_PDF_SUCCESS"
