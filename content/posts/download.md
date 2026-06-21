---
title: "폴리스너츠 한글판 패치 — 다운로드 · 설치 가이드"
date: 2026-06-16
categories: ["폴리스너츠 한글화"]
tags: ["폴리스너츠", "한글패치", "세가새턴", "xdelta"]
aliases: ["/posts/license/"]
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
- [ ] **추출 프로그램** — Redumper (무료, 추천)
- [ ] **패치 프로그램** — Delta Patcher (무료, 클릭 몇 번이면 끝)
- [ ] **이 한글 패치 파일** (위 다운로드 zip 안의 `patch/` 3개 + `cue/` 폴더)
  - `patch/policenauts_kr_disc1.xdelta`
  - `patch/policenauts_kr_disc2.xdelta`
  - `patch/policenauts_kr_disc3.xdelta`
  - `cue/` 폴더 (디스크별 .cue 3개)

> 이미 **CD 이미지 파일(BIN/CUE)** 을 가지고 있다면 → **1단계를 건너뛰고 2단계**로 가세요.

---

## 1. CD에서 이미지 뜨기 (추출)

> 이미 BIN/CUE 파일이 있으면 이 단계는 건너뜁니다.

폴리스너츠 CD는 **데이터(게임) + 오디오(음악) 두 트랙**으로 되어 있어, 둘 다 정확히 떠야 합니다. **Redumper**가 이걸 자동으로 처리해 줍니다.

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

> ❗ 형식 주의: 반드시 **BIN/CUE (2352바이트 원시 섹터)** 로 떠야 합니다.
> `.iso`(2048) 단일 파일은 이 패치와 호환되지 않습니다.

---

## 2. 내 이미지가 맞는 원본인지 확인 (해시 검증)

이 패치는 **딱 정해진 한 가지 덤프**에만 맞습니다. 내 데이터 트랙의 지문(SHA-1)을 대조해 보세요. **이게 맞으면 100% 성공**, 안 맞으면 다른 버전이라 적용이 거부됩니다.

> 💡 **해시(SHA-1)란?** 파일의 "지문"입니다. 같은 파일이면 늘 같은 값이 나오고, 1바이트만 달라도 값이 완전히 바뀝니다. 그래서 내 원본이 패치가 기대하는 바로 그 파일인지 확인할 수 있어요.

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

> ✅ **사실 해시 검증을 건너뛰어도 됩니다.** 3단계 패치 도구(Delta Patcher)가 원본을 **자동으로 확인**하므로, 틀린 원본이면 `XD3_INVALID_INPUT` 오류로 알아서 막아줍니다. 다만 미리 확인해 두면 어디가 잘못됐는지 빨리 알 수 있어요.

나온 값을 아래와 비교:

| 디스크 | 데이터 트랙(Track 1) SHA-1 |
|---|---|
| Disc 1 | `526bcd0ff248866f5d8c829c6c186f6c1a9c2405` |
| Disc 2 | `20edac717f607b1e0a10443f3480c96acd725450` |
| Disc 3 | `7c837f0a3a1c12ba430c0bf4feefabf518629220` |

- ✅ **일치** → 3단계로 진행
- ❌ **불일치** → 다른 리비전/잘못된 덤프입니다. (3단계 아래 FAQ "다른 형식을 가진 경우" 참고)

---

## 3. 패치 적용하기

**Delta Patcher** (GUI, 가장 쉬움)로 설명합니다.

1. [Delta Patcher](https://github.com/marco-calautti/DeltaPatcher/releases) 를 받아 실행합니다.
2. 화면에서:
   - **Original file** : `Policenauts (Japan) (Disc 1) (Track 1).bin` (내 원본 데이터 트랙)
   - **XDelta patch** : `policenauts_kr_disc1.xdelta`
3. **Apply patch** 버튼 클릭.
4. 같은 폴더에 패치된 **한글 데이터 트랙**이 생깁니다. 알아보기 쉽게 이름을 바꿔두세요:
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
→ 데이터+오디오가 한 파일에 붙은 "병합 BIN"입니다. cue가 함께 있으면 `binmerge` 같은 도구로 트랙을 분리한 뒤 2단계로 진행하세요. **병합 BIN에 패치를 직접 적용하면 안 됩니다** — 오류 없이 적용되더라도 오디오(음악)가 사라진 반쪽짜리가 됩니다.

**Q. `.iso` 파일(하나짜리)만 있어요.**
→ 헤더 없는 2048바이트 형식일 가능성이 큽니다. 이 패치는 **2352바이트 원시 섹터(BIN/CUE)** 기준이라 호환되지 않습니다. CD에서 BIN/CUE로 다시 뜨거나, 2352 규격 덤프를 사용하세요.

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
      │  ① Redumper 로 추출
      ▼
[BIN(데이터)+BIN(오디오)+CUE]   ← 디스크별
      │  ② SHA-1 해시 확인 (정본 맞는지)
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
