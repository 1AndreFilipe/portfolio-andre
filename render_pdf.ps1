$winmdPath = "C:\Windows\System32\WinMetadata"
$assemblies = @(
    "System.Runtime.WindowsRuntime",
    "$winmdPath\Windows.Foundation.winmd",
    "$winmdPath\Windows.Data.Pdf.winmd",
    "$winmdPath\Windows.Storage.winmd"
)

$code = @"
using System;
using System.IO;
using System.Threading.Tasks;
using Windows.Data.Pdf;
using Windows.Storage;
using Windows.Storage.Streams;

public class PdfRenderer
{
    public static async Task ConvertPdfToPng(string pdfPath, string pngPath)
    {
        StorageFile file = await StorageFile.GetFileFromPathAsync(pdfPath);
        PdfDocument pdfDoc = await PdfDocument.LoadFromFileAsync(file);
        using (PdfPage page = pdfDoc.GetPage(0))
        {
            var stream = new InMemoryRandomAccessStream();
            await page.RenderToStreamAsync(stream);
            using (var fileStream = new FileStream(pngPath, FileMode.Create))
            {
                var netStream = stream.AsStreamForRead();
                netStream.CopyTo(fileStream);
            }
        }
    }
}
"@

Add-Type -TypeDefinition $code -Language CSharp -ReferencedAssemblies $assemblies
[PdfRenderer]::ConvertPdfToPng("C:\Users\andre\Downloads\Email.pdf", "C:\Users\andre\Desktop\Work\portfolio-andre-main\images\email_agency_cover.png").Wait()
Write-Host "RENDERED_SUCCESSFULLY"
