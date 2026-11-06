param(
  [string]$WorkbookPath = 'C:\Users\almuafy\Downloads\ইসলামিক_সমিতি_হিসাব_ব্যবস্থাপনা.xlsx',
  [string]$OutputPath = '..\private-import\workbook-import.json'
)
$ErrorActionPreference = 'Stop'
$resolvedOutput = Join-Path $PSScriptRoot $OutputPath
$outputFolder = Split-Path -Parent $resolvedOutput
New-Item -ItemType Directory -Path $outputFolder -Force | Out-Null
$excel = $null; $book = $null
function CleanDigits([string]$value) {
  $bn='০১২৩৪৫৬৭৮৯'; $en='0123456789'
  for($i=0;$i -lt 10;$i++) { $value=$value.Replace([string]$bn[$i],[string]$en[$i]) }
  return $value
}
function CellValue($sheet,[int]$row,[int]$col) { return $sheet.Cells.Item($row,$col).Value2 }
try {
  if(-not (Test-Path -LiteralPath $WorkbookPath)) { throw 'Excel workbook not found.' }
  $excel=New-Object -ComObject Excel.Application
  $excel.Visible=$false; $excel.DisplayAlerts=$false
  $book=$excel.Workbooks.Open((Resolve-Path -LiteralPath $WorkbookPath).Path,$null,$true)
  $membersSheet=$book.Worksheets.Item('সদস্য তালিকা')
  $monthSheet=$book.Worksheets.Item('মাসিক চাঁদা')
  $yearSheet=$book.Worksheets.Item('বার্ষিক চাঁদা')
  $settingsSheet=$book.Worksheets.Item('সেটিংস')
  $members=@(); $monthly=@(); $yearly=@()
  $fiscalYear=CleanDigits([string](CellValue $settingsSheet 5 2))
  if(-not $fiscalYear) { $fiscalYear=CleanDigits([string]$monthSheet.Cells.Item(1,1).Text) -replace '^.*?(\d{4}[-–]\d{2}).*$','$1' }
  $monthNames=@('জুন','জুলাই','আগস্ট','সেপ্টেম্বর','অক্টোবর','নভেম্বর','ডিসেম্বর','জানুয়ারি','ফেব্রুয়ারি','মার্চ','এপ্রিল','মে')
  for($r=4;$r -le 28;$r++) {
    $name=[string](CellValue $membersSheet $r 2); $memberNo=[string](CellValue $membersSheet $r 3)
    if(-not $name -or -not $memberNo) { continue }
    $id='LEGACY-M-'+$r.ToString('000')
    $members += [ordered]@{id=$id;name=$name;membershipNo=$memberNo;shares=[double](CellValue $membersSheet $r 4);fatherName='';phone='';address='';joinDate='';monthlyFee=[double](CellValue $membersSheet $r 5);annualFee=[double](CellValue $membersSheet $r 6);status=[string](CellValue $membersSheet $r 10);createdAt=''}
    for($m=0;$m -lt 12;$m++) {
      $raw=CellValue $monthSheet $r ($m+5)
      if($null -eq $raw -or $raw -eq '') { continue }
      $amount=0.0
      if([double]::TryParse((CleanDigits([string]$raw)),[ref]$amount) -and $amount -gt 0) {
        $monthly += [ordered]@{id=('LEGACY-MON-'+$r.ToString('000')+'-'+$m.ToString('00'));memberId=$id;fiscalYear=$fiscalYear;month=$monthNames[$m];amount=$amount;date='';method='';notes='আগের হিসাব থেকে আমদানি';receiptNo='';createdAt=''}
      }
    }
    for($y=0;$y -lt 5;$y++) {
      $raw=CellValue $yearSheet $r ($y+5)
      if($null -eq $raw -or $raw -eq '') { continue }
      $year=CleanDigits([string]$yearSheet.Cells.Item(3,$y+5).Text)
      $amount=0.0
      if([double]::TryParse((CleanDigits([string]$raw)),[ref]$amount) -and $amount -gt 0) {
        $yearly += [ordered]@{id=('LEGACY-YEAR-'+$r.ToString('000')+'-'+$y.ToString('00'));memberId=$id;fiscalYear=$year;amount=$amount;date='';notes='আগের হিসাব থেকে আমদানি';receiptNo='';createdAt=''}
      }
    }
  }
  $payload=[ordered]@{members=$members;monthlyPayments=$monthly;yearlyPayments=$yearly;settings=@{societyName='স্বপ্নতরী';societyType='শেয়ার ভিত্তিক ব্যবসা প্রতিষ্ঠান';fiscalYear=$fiscalYear;monthsDueCount=[double](CellValue $settingsSheet 8 2);openingCash=[double](CellValue $settingsSheet 9 2);monthlyPerShare=1000;annualPerShare=5000;annualFeeUntil='2029-06';profitFund=95;khidmatFund=5}}
  $payload | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $resolvedOutput -Encoding utf8
  Write-Output ('Prepared private import: '+$members.Count+' members, '+$monthly.Count+' monthly entries, '+$yearly.Count+' annual entries.')
} finally {
  if($book) { $book.Close($false) }
  if($excel) { $excel.Quit(); [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) }
}
