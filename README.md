# CodePlay — 개발 블로그 (Hugo + PaperMod)

GitHub Pages 로 자동 배포되는 정적 개발 블로그.

- 사이트: https://razventi.github.io/dev_odyssey/
- 테마: PaperMod (git submodule)
- 빌드/배포: push → GitHub Actions(Hugo extended **0.150.0**) → Pages
- 홈은 시간순 글 피드 대신 **프로젝트 카드**를 보여주는 포털 형태

## 구조

```
hugo.toml                              사이트 설정(제목·메뉴·홈 프로필/프로젝트 카드)
content/
  about/index.md                       소개(프로필) 페이지  → /about/
  search.md                            검색 페이지         → /search/
  posts/                               블로그 글
    hello.md                           블로그 시작 글 (카테고리: 잡담)
    download.md                        패치 다운로드·적용법·이용조건(폴리스너츠 한글화)
    changelog.md                       패치 변경 이력
    policenauts-localization-guide.md  한글화 기술 가이드
    devlog-policenauts-1~3.md          개발기 3부작
  categories/                          카테고리 소개 페이지(_index.md)
    폴리스너츠-한글화/                  (완료, 글 묶임)
    머지시어터/ · 포커와-토비/ · 크로스히트/   (준비 중 프로젝트)
static/
  downloads/Policenauts_KR_v718.zip    배포 패치 zip
  img/policenauts-cover.jpg            홈 프로젝트 카드 커버
layouts/_markup/render-link.html       내부 링크에 /dev_odyssey/ 하위경로 보정 훅
.github/workflows/hugo.yml             push → 빌드 → Pages 자동 배포
```

## 글 추가

`content/posts/` 에 `.md` 를 만들고 front matter 지정 후 push 하면 1~2분 뒤 자동 반영됩니다.

```markdown
---
title: "글 제목"
date: 2026-06-17                  # 최신 날짜일수록 글 목록(/posts/) 위로
categories: ["폴리스너츠 한글화"]   # 프로젝트(카테고리)로 묶임
tags: ["태그1", "태그2"]
---
```

```bash
git add -A && git commit -m "새 글: 제목" && git push
```

> 글 목록 정렬은 **date 내림차순**(최신이 위). 같은 날 여러 글은 시간까지(`T13:00:00+09:00`) 주면 구분됨.

## 홈 프로젝트 카드 관리

홈 화면 카드는 `hugo.toml` 의 `[params.homeInfoParams]` Content 안 `<div class="proj-grid">` 에 정의돼 있다.

- **새 프로젝트 추가**: 카드 `<a class="proj-card …">` 블록을 복사해 넣고, 커버 이미지가 있으면
  `static/img/` 에 두고 `<img src="/dev_odyssey/img/파일명">`, 없으면 `<div class="ph">이모지</div>`.
  준비 중이면 클래스에 `soon` 추가(흐리게 표시). 링크는 `/dev_odyssey/categories/<슬러그>/`.
- **프로젝트 숨김**: 해당 카드 `<a>` 블록만 지우면 됨(카테고리 파일은 남겨도 무방 — 링크만 없으면 안 보임).
- 카드가 가리키는 **카테고리 소개 페이지**는 `content/categories/<이름>/_index.md` 로 만든다(준비중 프로젝트도 동일).

> 홈에서 시간순 글 피드를 숨기기 위해 `[params] mainSections = ["projects"]`(존재하지 않는 섹션)로 둠.
> 글들은 `/posts/`(글 목록 메뉴)와 각 카테고리 페이지에서 볼 수 있다.

## 하위경로(/dev_odyssey/) 주의

- 사이트가 프로젝트 하위경로에 배포되므로, **상단 메뉴 url 은 앞 슬래시 없이**(`posts/`) 쓴다
  (PaperMod 가 `absLangURL` 로 baseURL 하위경로를 붙임).
- 본문 마크다운의 루트상대 링크(`/posts/…`, `/categories/…`, `/downloads/…`)는
  `layouts/_markup/render-link.html` 훅이 자동으로 하위경로를 보정한다.
- 홈 카드처럼 **raw HTML 의 `<a href>`/`<img src>`** 는 훅을 안 타므로 `/dev_odyssey/…` 를 직접 적는다.

## 배포 (이미 설정 완료)

1. push → `.github/workflows/hugo.yml` 가 Hugo 설치 → 빌드 → Pages 배포.
2. (최초 1회) 저장소 **Settings → Pages → Source: `GitHub Actions`** 로 설정해야 동작.
3. 진행 상황: 저장소 **Actions** 탭. 초록 ✓ 면 https://razventi.github.io/dev_odyssey/ 반영.

## 로컬 미리보기 (선택)

Hugo extended(≥0.146) 설치 후:
```bash
hugo server -D     # http://localhost:1313
```
설치: `choco install hugo-extended` (Windows) 또는 공식 릴리스 바이너리.
