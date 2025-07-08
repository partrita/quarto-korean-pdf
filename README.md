# quarto-korean-pdf

Quarto로 한국어가 포함된 PDF 파일을 생성.

# 로컬 작업 명령어


```bash
pixi init
pixi add quarto font-ttf-noto-cjk
pixi run quarto install tool tinytex
pixi run quarto create project book mybook
cd mybook
```

## Preview
```bash
# preview the book in the current directory
pixi run quarto preview
```

## Publishing PDF file

```bash
#pixi run quarto render           # render all formats
pixi run quarto render --to pdf  # render PDF format only
```

