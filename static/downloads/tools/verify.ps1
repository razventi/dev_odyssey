# Policenauts KR v1.0.0 - 덤프/패치 검증 헬퍼
# 사용법:
#   .\verify.ps1                      # 현재 폴더의 모든 .bin 검사
#   .\verify.ps1 "경로\파일.bin"       # 특정 파일만 검사
# 파일의 SHA-1과 크기를 정본 표와 대조해 어떤 디스크/트랙인지(원본/한글/오디오) 알려줍니다.

param([string[]]$Files)

$known = @(
  @{ Label='Disc1 원본 데이터(Track1)'; Sha='526bcd0ff248866f5d8c829c6c186f6c1a9c2405'; Size=524338416 },
  @{ Label='Disc1 한글 데이터(Track1)'; Sha='29fae4a3d0d59640b4910dc242d7dbe97e5f9a4c'; Size=531831888 },
  @{ Label='Disc2 원본 데이터(Track1)'; Sha='20edac717f607b1e0a10443f3480c96acd725450'; Size=560211120 },
  @{ Label='Disc2 한글 데이터(Track1)'; Sha='e90d415ee1b842d099c00ce16977c6b62f00bb1f'; Size=567704592 },
  @{ Label='Disc3 원본 데이터(Track1)'; Sha='7c837f0a3a1c12ba430c0bf4feefabf518629220'; Size=513533328 },
  @{ Label='Disc3 한글 데이터(Track1)'; Sha='ae33cecbf009d1d65f6b566b031a080d721948ef'; Size=521026800 },
  @{ Label='오디오(Track2, redump 정본·pregap 포함)'; Sha='c82651fc2d60c768dbfcc75b9cdec580ec07d307'; Size=4812192 }
)

# 오디오 트랙은 드라이브 read-offset/pregap 처리에 따라 SHA-1이 정상적으로 달라집니다.
# 패치는 데이터 트랙(Track1)에만 적용되므로, 오디오는 '크기'로만 인식해 정상 처리합니다.
#   4,812,192 = redump 정본(pregap 150섹터 포함)
#   4,459,392 = 합본 BIN 분리본(pregap 미포함, ImgBurn+split.ps1 등) — 게임 동작에 지장 없음
$audioSizes = @(4812192, 4459392)
# 데이터 트랙의 정본 크기 모음 (크기는 같은데 SHA만 다르면 = 드라이브 오독/손상)
$dataSizes = $known | Where-Object { $audioSizes -notcontains $_.Size } | ForEach-Object { $_.Size }

if (-not $Files) { $Files = Get-ChildItem -Filter *.bin | ForEach-Object { $_.FullName } }
if (-not $Files) { Write-Host "검사할 .bin 파일이 없습니다." -ForegroundColor Yellow; return }

foreach ($f in $Files) {
  if (-not (Test-Path $f)) { Write-Host "[없음] $f" -ForegroundColor Red; continue }
  $item = Get-Item $f
  $sha  = (Get-FileHash $f -Algorithm SHA1).Hash.ToLower()
  $size = $item.Length
  $match = $known | Where-Object { $_.Sha -eq $sha }

  Write-Host ""
  Write-Host $item.Name -ForegroundColor Cyan
  Write-Host ("  크기  : {0:N0} bytes" -f $size)
  Write-Host ("  SHA-1 : $sha")
  if ($match) {
    Write-Host ("  ==> [OK] $($match.Label)") -ForegroundColor Green
  } elseif ($audioSizes -contains $size) {
    # 오디오 트랙: SHA-1이 정본과 달라도 정상 (패치 무관, 게임 동작에 지장 없음)
    Write-Host ("  ==> [정상] 오디오 트랙(Track2) — SHA-1이 정본과 달라도 OK, 패치는 데이터 트랙에만 적용됩니다") -ForegroundColor Green
  } elseif ($dataSizes -contains $size) {
    Write-Host ("  ==> [경고] 데이터 트랙 크기와 같으나 SHA-1 불일치 → 드라이브 오독/손상/다른 리비전 의심") -ForegroundColor Yellow
  } else {
    Write-Host ("  ==> [불일치] 정본 표에 없는 파일 (병합 BIN/.iso/다른 덤프 의심)") -ForegroundColor Red
  }
}
Write-Host ""
