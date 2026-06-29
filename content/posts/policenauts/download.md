---
title: "폴리스너츠 한글판 패치 — 다운로드 · 설치 가이드"
date: 2026-06-21
categories: ["policenauts"]
tags: ["폴리스너츠", "한글패치", "세가새턴", "xdelta"]
---

세가 새턴 「폴리스너츠(Policenauts)」 일본판을 한국어로 즐기는 방법입니다.
**CD에서 이미지 뜨기 → 패치 적용 → 게임 실행**까지, 순서대로만 따라 하면 됩니다.

> 💡 한 줄 요약: **내 일본판 CD를 컴퓨터 파일(BIN/CUE)로 떠서 → 패치 프로그램으로 한글로 바꾼 뒤 → 실행용 폴더로 구성**합니다. 디스크가 3장이니 같은 작업을 3번 반복해요.

---

## 다운로드

> 📦 [**최신 패치 다운로드 — Policenauts_KR_v1.0.0.zip**](/downloads/Policenauts_KR_v1.0.0.zip)

배포본 구성:

```
patch/   policenauts_kr_disc1~3.xdelta
cue/     Policenauts_KR (Disc 1~3).cue
README.txt
```

> **v1.0.0** — 시작부터 엔딩까지 통플레이 검수 완료.

---

## ⚠️ 시작 전에 (중요)

- 이 패치는 **본인이 합법적으로 소유한 일본판 폴리스너츠 원본 CD**에만 사용하세요.
- 패치 파일은 게임 데이터를 포함하지 않습니다. **원본 CD(또는 그 이미지)가 반드시 있어야** 합니다.
- 패치나 패치된 게임 데이터를 **재배포·판매하는 것은 금지**입니다.
- 작업 전 원본은 꼭 백업해 두세요.

---

## 0. 준비물 체크리스트

- [ ] **일본판 폴리스너츠 CD 3장** (Disc 1·2·3)
- [ ] **CD를 읽을 수 있는 PC 광학 드라이브** (내장 또는 외장 USB)
- [ ] **추출 프로그램** — 아래 둘 중 하나
  - **Redumper** (무료, redump 표준) — 트랙을 자동으로 분리해 줌
  - **ImgBurn** (무료) — 호환성이 넓음. 단 합본으로 나와 분리 단계가 추가됨
- [ ] **패치 프로그램** — Delta Patcher (무료, 클릭 몇 번이면 끝)
- [ ] **이 한글 패치 파일** (위 다운로드 zip 안의 `patch/` 3개 + `cue/` 폴더)
  - `patch/policenauts_kr_disc1.xdelta`
  - `patch/policenauts_kr_disc2.xdelta`
  - `patch/policenauts_kr_disc3.xdelta`
  - `cue/` 폴더 (디스크별 .cue 3개)

> 이미 **CD 이미지 파일(BIN/CUE)** 을 가지고 있다면 → **1단계를 건너뛰고 2단계**로 가세요.

---

## 1. CD에서 이미지 뜨기 (추출)

폴리스너츠 CD는 **데이터(게임) + 오디오(음악) 두 트랙**으로 되어 있어, 둘 다 정확히 떠야 합니다.
**아래 두 방법 중 하나**를 쓰세요. 핵심은 **패치는 데이터 트랙(Track 1)에만 적용**되므로, 최종적으로 `(Track 1).bin`(데이터)과 `(Track 2).bin`(오디오)이 **분리된 상태**가 되어야 한다는 점입니다.

> 🧭 **어느 방법을 고를까?**
> - 먼저 **방법 A(Redumper)** 를 시도하세요. 트랙을 자동 분리해 가장 간편합니다.
> - Redumper가 **C2 오류**나 **lead-out 오류**로 자꾸 실패한다면(특히 redump 데이터베이스에 없는 드라이브에서) → **방법 B(ImgBurn)** 로 가세요. 데이터 섹터를 단순하게 읽어 호환성이 넓습니다.

> ❗ 공통 형식 주의: 반드시 **BIN/CUE (2352바이트 원시 섹터)** 로 떠야 합니다.
> `.iso`(2048) 단일 파일은 이 패치와 호환되지 않습니다.

---

### 방법 A) Redumper — 트랙 자동 분리 (권장)

1. [Redumper](https://github.com/superg/redumper/releases) 를 받아 압축을 풉니다.
2. Disc 1을 드라이브에 넣고, 명령 프롬프트(또는 PowerShell)에서:
   ```
   redumper --drive=D: --image-name="Policenauts (Japan) (Disc 1)"
   ```
   *(`D:` 는 본인 CD 드라이브 문자로 바꾸세요.)*
3. 끝나면 다음 파일들이 생깁니다:
   - `Policenauts (Japan) (Disc 1) (Track 1).bin` ← 데이터(게임)
   - `Policenauts (Japan) (Disc 1) (Track 2).bin` ← 오디오(음악)
   - `Policenauts (Japan) (Disc 1).cue` ← 트랙 구성표
4. **Disc 2, Disc 3도 똑같이** 반복합니다. (디스크별로 폴더를 나누면 헷갈리지 않아요.)

> 💬 Redumper가 **"data errors detected"** / **C2 오류 다수** / **lead-out 읽기 실패**로 멈춘다면, 그건 보통 **드라이브가 이 디스크를 정확히 못 읽는 것**입니다. 디스크를 닦아 다시 시도하거나, **방법 B(ImgBurn)** 또는 **다른 광학 드라이브**를 쓰세요.

---

### 방법 B) ImgBurn + binmerge — 호환성 대안

ImgBurn은 데이터 섹터를 단순하게 읽어, 까다로운 드라이브에서도 추출이 잘 되는 편입니다. 다만 **데이터+오디오가 하나로 합쳐진 BIN**으로 나오므로, 추출 뒤 **트랙을 분리**해야 합니다.

**B-1. ImgBurn으로 CD를 이미지로 읽기**
1. [ImgBurn](https://www.imgburn.com/) 을 설치하고 실행합니다.
2. **"Read"(디스크를 이미지 파일로 읽기)** 모드를 선택합니다.
3. **Source**: CD 드라이브 / **Destination**: 저장할 폴더·파일명 지정
4. 읽기 속도를 **낮게(4~8x)** 두면 안정적입니다.
5. 시작하면 합본 형태로 생성됩니다:
   - `Policenauts (Japan) (Disc 1).bin` ← 데이터+오디오 합본
   - `Policenauts (Japan) (Disc 1).cue` ← 트랙 구성표

**B-2. 트랙 분리 (`split.ps1` — Python 불필요)**

패치는 데이터 트랙에만 적용되므로, 합본 BIN을 트랙별로 나눕니다. 동봉 스크립트 [`split.ps1`](/downloads/tools/split.ps1) 을 쓰면 별도 프로그램 설치 없이 끝납니다.

1. [`split.ps1`](/downloads/tools/split.ps1) 을 받아, ImgBurn으로 만든 `.bin`/`.cue` 가 있는 폴더에 둡니다.
2. 그 폴더에서 **PowerShell**을 열고:
   ```
   .\split.ps1 "Policenauts (Japan) (Disc 1).cue" -OutDir "out\disc1" -Name "Policenauts (Japan) (Disc 1)"
   ```
3. `out\disc1` 에 다음이 생깁니다:
   - `Policenauts (Japan) (Disc 1) (Track 1).bin` ← 데이터(게임)
   - `Policenauts (Japan) (Disc 1) (Track 2).bin` ← 오디오(음악)
   - `Policenauts (Japan) (Disc 1).cue`
4. **Disc 2, Disc 3도** `disc2`/`disc3` 로 바꿔 반복.

> 💡 PowerShell이 스크립트 실행을 막으면, 다음처럼 실행하세요:
> `powershell -ExecutionPolicy Bypass -File .\split.ps1 "...cue" -OutDir "out\disc1" -Name "..."`
> 💡 Python을 선호하시면 [binmerge](https://github.com/putnam/binmerge)로 `python binmerge -s -o 출력폴더 "...cue" "이름"` 해도 동일한 결과가 나옵니다.

> ℹ️ **오디오 트랙(Track 2) 참고:** 이 방법에서 데이터 트랙(Track 1)은 **정본과 SHA-1까지 100% 동일**하지만, 오디오 트랙은 pregap(2초·150섹터)을 파일에 담지 않는 덤프 방식 차이로 **redump 정본(4,812,192바이트)보다 작은 4,459,392바이트(약 4.46MB)** 로 나오고 SHA-1도 다릅니다. **이는 정상입니다.** 패치는 데이터 트랙에만 적용되고 오디오는 그대로 쓰이므로 **게임 실행에 전혀 지장이 없습니다.** (그래서 아래 `verify.ps1`도 오디오 트랙은 크기로만 확인해 `[정상]` 으로 표시합니다.)

---

## 2. 내 이미지가 맞는 원본인지 확인 (해시 검증)

이 패치는 **딱 정해진 한 가지 덤프**에만 맞습니다. 내 데이터 트랙의 지문(SHA-1)을 대조해 보세요. **이게 맞으면 100% 성공**, 안 맞으면 다른 버전이라 적용이 거부됩니다.

> 💡 **해시(SHA-1)란?** 파일의 "지문"입니다. 같은 파일이면 늘 같은 값이 나오고, 1바이트만 달라도 값이 완전히 바뀝니다. 그래서 내 원본이 패치가 기대하는 바로 그 파일인지 확인할 수 있어요.

> ⭐ **방법 B(ImgBurn)를 썼다면 이 검증을 꼭 하세요.** ImgBurn은 읽기 오류를 깐깐하게 막지 않으므로, SHA-1 확인이 "내 드라이브가 데이터를 정확히 읽었는지"를 보장하는 유일한 안전장치입니다.

> 🛠 **간편 자동 검증:** 동봉 [`verify.ps1`](/downloads/tools/verify.ps1) 에 `.bin` 파일을 넘기면 정본/한글/오디오 표와 자동으로 대조해 알려줍니다. 인자 없이 실행하면 현재 폴더의 모든 `.bin`을 한꺼번에 검사합니다.
> ```
> .\verify.ps1 "Policenauts (Japan) (Disc 1) (Track 1).bin"
> ```
> 결과 표시: `[OK]` 정본/한글 데이터 트랙 일치 · `[정상]` 오디오 트랙(SHA-1 달라도 정상) · `[경고]` 데이터 크기는 같은데 SHA-1 불일치(드라이브 오독 의심) · `[불일치]` 표에 없는 파일.
> **오디오 트랙(Track 2)이 `[정상]` 으로 나오면 SHA-1이 정본과 달라도 괜찮습니다.** (드라이브 오프셋·pregap 차이일 뿐, 게임에 지장 없음)
> 아래는 수동으로 SHA-1을 구하는 방법입니다.

아래 **세 가지 방법 중 하나**로 내 데이터 트랙(`... (Track 1).bin`)의 SHA-1을 구하세요. (대소문자는 무시하고 비교하면 됩니다.)

### 방법 A) 명령 프롬프트 — `certutil` (설치 불필요, 가장 간단)
```
certutil -hashfile "Policenauts (Japan) (Disc 1) (Track 1).bin" SHA1
```
> 팁: 파일이 있는 폴더의 주소창에 `cmd` 입력 → 엔터 → 그 폴더에서 위 명령 실행.
> `certutil -hashfile ` 까지 친 뒤 **파일을 명령창에 끌어다 놓으면** 경로가 자동 입력됩니다.

### 방법 B) PowerShell — `Get-FileHash`
```
Get-FileHash "Policenauts (Japan) (Disc 1) (Track 1).bin" -Algorithm SHA1
```

### 방법 C) 마우스로만 (GUI 도구)
- **7-Zip**: 파일 우클릭 → `CRC SHA` → `SHA-1`
- **HashCheck**: 설치하면 파일 우클릭 → 속성에 "해시(Checksums)" 탭이 생김

나온 값을 아래와 비교:

| 디스크 | 데이터 트랙(Track 1) SHA-1 |
|---|---|
| Disc 1 | `526bcd0ff248866f5d8c829c6c186f6c1a9c2405` |
| Disc 2 | `20edac717f607b1e0a10443f3480c96acd725450` |
| Disc 3 | `7c837f0a3a1c12ba430c0bf4feefabf518629220` |

- ✅ **일치** → 3단계로 진행
- ❌ **불일치** → 다른 리비전/잘못된 덤프이거나, **드라이브가 데이터를 잘못 읽은 것**입니다. (아래 FAQ 참고. 크기는 같은데 해시만 다르면 → 드라이브 읽기 문제일 가능성이 큽니다 → 디스크 청소 후 재시도, 또는 다른 드라이브/방법)

---

## 3. 패치 적용하기

**Delta Patcher** (GUI, 가장 쉬움)로 설명합니다.

1. [Delta Patcher](https://github.com/marco-calautti/DeltaPatcher/releases) 를 받아 실행합니다.
2. 화면에서:
   - **Original file** : `Policenauts (Japan) (Disc 1) (Track 1).bin` (내 원본 데이터 트랙)
   - **XDelta patch** : `policenauts_kr_disc1.xdelta`
3. **Apply patch** 버튼 클릭.
4. 패치된 **한글 데이터 트랙**이 만들어집니다. 알아보기 쉽게 이름을 바꿔두세요:
   `Policenauts_KR (Disc 1) (Track 1).bin`
5. **Disc 2, Disc 3도** 각자의 `.xdelta`로 똑같이 반복.

> 💬 `XD3_INVALID_INPUT` / `source checksum mismatch` 오류가 나면?
> → 원본이 이 패치와 다른 덤프입니다. 2단계 해시를 다시 확인하세요. (엉뚱한 결과가 나오는 게 아니라 안전하게 거부하는 것입니다.)

<details>
<summary>명령줄(xdelta3)로 하고 싶다면</summary>

```
xdelta3 -d -s "Policenauts (Japan) (Disc 1) (Track 1).bin" policenauts_kr_disc1.xdelta "Policenauts_KR (Disc 1) (Track 1).bin"
```
</details>

---

## 4. 게임 실행용으로 구성하기

한 폴더 안에 디스크별로 **3개 파일**을 모읍니다:

| 역할 | 파일 |
|---|---|
| 한글 데이터 트랙 | `Policenauts_KR (Disc 1) (Track 1).bin` ← 3단계에서 만든 것 |
| 오디오 트랙 | `Policenauts (Japan) (Disc 1) (Track 2).bin` ← 원본 그대로 복사 |
| 트랙 구성표 | `Policenauts_KR (Disc 1).cue` ← 동봉된 `cue/` 폴더에서 복사 |

> 동봉 cue의 파일명과 위 파일명이 정확히 같아야 합니다. (cue 안에 어떤 파일을 부를지 적혀 있어요.)

Disc 2·3도 같은 방식으로 폴더를 구성합니다.

이렇게 디스크별로 **`Policenauts_KR (Disc N).cue`** 를 열 수 있는 상태가 되면 한글 패치 적용은 완료입니다. 🎉

---

## 자주 묻는 질문 (FAQ)

**Q. 내 파일이 큰 BIN 하나로 합쳐져 있어요 (트랙이 안 나뉨).**
→ 데이터+오디오가 한 파일에 붙은 "병합 BIN"입니다(ImgBurn 등으로 뜨면 이렇게 나옵니다). cue가 함께 있으면 위 **방법 B-2의 binmerge**로 트랙을 분리한 뒤 2단계로 진행하세요. **병합 BIN에 패치를 직접 적용하면 안 됩니다** — 오류 없이 적용되더라도 오디오(음악)가 사라진 반쪽짜리가 됩니다.

**Q. `.iso` 파일(하나짜리)만 있어요.**
→ 헤더 없는 2048바이트 형식일 가능성이 큽니다. 이 패치는 **2352바이트 원시 섹터(BIN/CUE)** 기준이라 호환되지 않습니다. CD에서 BIN/CUE로 다시 뜨거나, 2352 규격 덤프를 사용하세요.

**Q. Redumper/DIC가 C2 오류나 lead-out 오류로 계속 실패해요.**
→ redump 데이터베이스에 없는 드라이브(특히 일부 노트북·외장 슬림 드라이브)에서 흔합니다. 이 도구들은 정밀 검증을 하기 때문에 드라이브가 못 따라오면 멈춥니다. → **방법 B(ImgBurn)** 로 떠서 binmerge로 분리한 뒤 **2단계 해시 검증**을 해보세요. 해시가 맞으면 그대로 진행하면 됩니다. 그래도 해시가 안 맞으면 **다른 광학 드라이브**가 필요합니다.

**Q. 크기는 정본과 같은데 SHA-1만 달라요.**
→ 길이는 맞는데 내용이 다르다는 건, **드라이브가 데이터의 일부 바이트를 잘못 읽었다**는 뜻입니다(디스크 오염/긁힘 또는 드라이브 한계). 디스크를 닦고 다시 추출하거나, 다른 드라이브/방법을 시도하세요.

**Q. 패치가 잘 됐는지 확인하고 싶어요.**
→ 패치 후 데이터 트랙의 SHA-1이 아래와 같으면 정상입니다:

| 디스크 | 한글 Track 1 SHA-1 |
|---|---|
| Disc 1 | `29fae4a3d0d59640b4910dc242d7dbe97e5f9a4c` |
| Disc 2 | `e90d415ee1b842d099c00ce16977c6b62f00bb1f` |
| Disc 3 | `ae33cecbf009d1d65f6b566b031a080d721948ef` |

> 배포본 zip 안의 `README.txt` 에도 디스크별 원본/한글 Track1·원본 Track2 SHA-1 과 패치 크기가 정리되어 있습니다.

---

## 전체 흐름 한눈에

```
[일본판 CD 3장]
      │  ① 추출
      │     · 방법 A: Redumper            → 트랙 자동 분리
      │     · 방법 B: ImgBurn → binmerge  → 합본 추출 후 트랙 분리
      ▼
[BIN(데이터)+BIN(오디오)+CUE]   ← 디스크별, 트랙 분리된 상태
      │  ② SHA-1 해시 확인 (정본 맞는지)  ← 방법 B면 특히 필수
      ▼
[Delta Patcher 로 데이터 트랙에 패치 적용]   ← ③
      │
      ▼
[한글 데이터 BIN + 원본 오디오 BIN + 동봉 CUE 를 한 폴더에]   ← ④
      │
      ▼
[디스크별 .cue 로 실행 준비 완료 → 한글 플레이!]
```

즐거운 플레이 되세요! 문제가 생기면 2단계 해시 확인부터 다시 점검하는 것이 가장 빠른 해결책입니다.

---

## 오역·버그 제보

플레이 중 **오역, 어색한 문장, 깨진 글자, 진행 불가 등 버그**를 발견하시면 알려주세요. 다음 버전에 반영하겠습니다.

- 📧 이메일: **razventi@gmail.com**
- 제보 시 **디스크 번호와 해당 장면(또는 대략적인 위치)**, 가능하면 **스크린샷**을 함께 보내주시면 큰 도움이 됩니다.

---

## 이용 조건 및 면책

- 본 패치는 **비영리 팬 번역물**이며, 게임 데이터를 일절 포함하지 않습니다.
  원본 게임의 저작권은 **KONAMI** 에 있습니다.
- 본 패치는 **원본 게임(Policenauts, 일본판)을 합법적으로 소유한 이용자**가
  **개인적 용도로만** 사용해야 합니다.
- 패치 또는 패치가 적용된 게임 데이터(BIN/CUE/CHD 등)를 **재배포·판매하는 행위를 금지**합니다.
  본 패치 파일 자체의 비영리적 공유만 허용합니다.
- 본 패치 사용으로 발생하는 **어떠한 문제(데이터 손상·법적 책임 등)에 대해 제작자는 책임지지 않습니다.**
  사용 전 원본을 반드시 백업하세요.
- 저작권자(KONAMI)의 요청이 있을 경우 **배포를 즉시 중단합니다.**

> 위 고지는 법률 자문이 아니며, 일반적인 팬 번역 배포 관행에 따른 것입니다.
