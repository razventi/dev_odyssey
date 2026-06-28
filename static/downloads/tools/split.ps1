# 합본 BIN/CUE를 트랙별 BIN으로 분리 (Python 불필요, PowerShell 내장만 사용)
# 사용법:
#   .\split.ps1 "합본.cue"                         # 같은 폴더에 분리 결과 생성
#   .\split.ps1 "합본.cue" -OutDir "출력폴더" -Name "Policenauts (Japan) (Disc 3)"
# 동작: cue의 트랙 경계를 읽어 합본 BIN을 (Track 1).bin / (Track 2).bin ... 으로 자르고,
#       분리된 트랙을 가리키는 새 cue를 만듭니다. (INDEX 00/PREGAP 모두 처리)

param(
  [Parameter(Mandatory=$true)][string]$Cue,
  [string]$OutDir = ".",
  [string]$Name
)
$ErrorActionPreference = 'Stop'
$SECTOR = 2352

function MsfToSectors([string]$msf){
  $p = $msf -split ':'
  return ([int]$p[0]*60 + [int]$p[1])*75 + [int]$p[2]
}

$cueItem = Get-Item $Cue
$cueDir  = $cueItem.DirectoryName
if(-not $Name){ $Name = [IO.Path]::GetFileNameWithoutExtension($cueItem.Name) }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$OutDir = (Get-Item $OutDir).FullName

# --- cue 파싱 ---
$binName = $null; $tracks = @(); $cur = $null
foreach($ln in (Get-Content $cueItem.FullName)){
  $t = $ln.Trim()
  if($t -match '^FILE\s+"(.+)"\s+BINARY'){ $binName = $Matches[1]; continue }
  if($t -match '^TRACK\s+(\d+)\s+(\S+)'){
    if($cur){ $tracks += $cur }
    $cur = @{ Num=[int]$Matches[1]; Mode=$Matches[2]; Start=$null }
    continue
  }
  if($t -match '^INDEX\s+00\s+(\d+:\d+:\d+)'){ $cur.Start = MsfToSectors $Matches[1]; continue }
  if($t -match '^INDEX\s+01\s+(\d+:\d+:\d+)'){ if($null -eq $cur.Start){ $cur.Start = MsfToSectors $Matches[1] }; continue }
}
if($cur){ $tracks += $cur }
if(-not $binName){ throw "cue에서 FILE 항목을 찾지 못했습니다." }

$binPath = Join-Path $cueDir $binName
$binLen  = (Get-Item $binPath).Length
$totalSectors = [long]($binLen / $SECTOR)

# --- 분리 ---
$buf = New-Object byte[] 4194304   # 4MB
$fsIn = [IO.File]::OpenRead($binPath)
$cueOut = @()
try {
  for($i=0; $i -lt $tracks.Count; $i++){
    $tr = $tracks[$i]
    $startSector = [long]$tr.Start
    $endSector   = if($i -lt $tracks.Count-1){ [long]$tracks[$i+1].Start } else { $totalSectors }
    $len = ($endSector - $startSector) * $SECTOR
    $outName = "{0} (Track {1}).bin" -f $Name, $tr.Num
    $outPath = Join-Path $OutDir $outName
    Write-Host ("Track {0} ({1}) -> {2}  [{3:N0} bytes]" -f $tr.Num, $tr.Mode, $outName, $len)
    $fsIn.Seek($startSector*$SECTOR, 'Begin') | Out-Null
    $fsOut = [IO.File]::Create($outPath)
    try {
      $remaining = $len
      while($remaining -gt 0){
        $toRead = [Math]::Min([long]$buf.Length, $remaining)
        $read = $fsIn.Read($buf, 0, [int]$toRead)
        if($read -le 0){ break }
        $fsOut.Write($buf, 0, $read)
        $remaining -= $read
      }
    } finally { $fsOut.Close() }
    $cueOut += ('FILE "{0}" BINARY' -f $outName)
    $cueOut += ('  TRACK {0:D2} {1}' -f $tr.Num, $tr.Mode)
    $cueOut += '    INDEX 01 00:00:00'
  }
} finally { $fsIn.Close() }

$cuePath = Join-Path $OutDir ("{0}.cue" -f $Name)
Set-Content -Path $cuePath -Value $cueOut -Encoding ASCII
Write-Host "새 cue: $cuePath" -ForegroundColor Green
