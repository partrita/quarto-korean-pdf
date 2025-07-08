# quarto-korean-pdf

## 목적

이 프로젝트는 [Quarto](https://quarto.org/)를 사용하여 한국어 콘텐츠가 포함된 PDF 문서를 생성하는 방법을 보여줍니다. `pixi`를 사용하여 프로젝트 환경 및 종속성을 관리합니다.

## 프로젝트 구조

```
.
├── .github/workflows/main.yml  # GitHub Actions 워크플로 파일
├── mybook/                     # Quarto 책 프로젝트 디렉터리
│   ├── _quarto.yml             # Quarto 프로젝트 구성 파일
│   ├── index.qmd               # 책의 기본 랜딩 페이지
│   ├── intro.qmd               # 예제 장
│   ├── references.bib          # 참고 문헌 (BibTeX 형식)
│   ├── references.qmd          # 참고 문헌 표시용 Quarto 파일
│   └── summary.qmd             # 예제 장
├── .gitignore                  # Git에서 무시할 파일을 지정
├── LICENSE                     # 프로젝트 라이선스 파일
├── README.md                   # 이 파일
├── pixi.lock                   # pixi 종속성의 정확한 버전 잠금 파일
└── pixi.toml                   # pixi 프로젝트 구성 및 종속성 파일
```

## 로컬 작업 명령어

다음은 로컬 시스템에서 이 프로젝트를 설정하고 빌드하는 단계입니다.

1.  **pixi 초기화:**
    ```bash
    pixi init
    ```
    현재 디렉터리에서 `pixi` 프로젝트를 초기화합니다. (이미 `pixi.toml`이 있는 경우 이 단계는 필요하지 않을 수 있습니다.)

2.  **종속성 설치:**
    ```bash
    pixi install
    ```
    `pixi.toml` 파일에 정의된 모든 프로젝트 종속성을 설치합니다. `pixi add <package>`를 사용하여 새 종속성을 추가할 수 있으며, 이는 자동으로 `pixi.toml`에 추가됩니다. 예를 들어, 처음 설정하는 경우 다음을 실행할 수 있습니다.
    ```bash
    pixi add quarto
    ```

3.  **TinyTeX 설치:**
    ```bash
    pixi run quarto install tool tinytex
    ```
    Quarto가 PDF를 렌더링하는 데 필요한 LaTeX 배포판인 TinyTeX를 설치합니다.

4.  **Quarto 책 프로젝트 생성 (필요한 경우):**
    ```bash
    # pixi run quarto create project book mybook
    # cd mybook
    ```
    `mybook`이라는 새 Quarto 책 프로젝트를 생성합니다. 이 저장소에는 이미 `mybook` 디렉터리가 포함되어 있으므로 일반적으로 이 단계는 필요하지 않습니다.

## 미리보기

책의 변경 사항을 로컬에서 미리 보려면 다음을 실행합니다.

```bash
# 'mybook' 디렉터리 내에서 실행
pixi run quarto preview
```
그러면 웹 브라우저에서 미리보기가 시작되고 소스 파일이 변경되면 자동으로 새로 고쳐집니다.

## PDF 파일 게시

PDF 파일을 생성하려면 다음 명령을 사용합니다.

```bash
# 'mybook' 디렉터리 내에서 실행
# pixi run quarto render           # 모든 형식 렌더링
pixi run quarto render --to pdf  # PDF 형식만 렌더링
```
생성된 PDF는 `_book/mybook.pdf`에 있습니다.

## GitHub Actions

이 저장소는 GitHub Actions를 사용하여 다음을 자동화합니다.

*   `main` 브랜치에 푸시하거나 풀 리퀘스트가 있을 때마다 `mybook` 디렉터리 내의 Quarto 프로젝트를 빌드합니다.
*   빌드된 PDF 파일(`mybook.pdf`)을 워크플로 실행의 아티팩트로 업로드합니다. "quarto-pdf-book"이라는 이름으로 찾을 수 있습니다.
*   `main` 브랜치에 푸시가 발생하면 새 GitHub 릴리스를 만들고 빌드된 PDF를 해당 릴리스에 첨부합니다.

이 자동화는 `.github/workflows/main.yml` 파일에 정의되어 있습니다.