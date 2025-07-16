# Ubuntu 22.04 (Jammy Jellyfish)를 베이스 이미지로 사용
FROM ubuntu:22.04

# 환경 변수 설정 (옵션)
ENV DEBIAN_FRONTEND=noninteractive


# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     sudo \
#     curl \
#     wget \
#     git \
#     ca-certificates \
#     fontconfig \
#     locales \
    # fonts-noto-cjk \
#     && \
#     rm -rf /var/lib/apt/lists/*

# # 한국어 로케일 설정 (필요한 경우 유지)
# ENV LANG=ko_KR.UTF-8
# ENV LANGUAGE=ko_KR:en
# ENV LC_ALL=ko_KR.UTF-8

# Pixi 설치
RUN curl -fsSL https://pixi.sh/install.sh | bash
ENV PATH="/root/.pixi/bin:${PATH}"

# Quarto 프로젝트를 위한 작업 디렉토리 생성
WORKDIR /app

# Pixi 환경 설정 (pixi.toml 및 pixi.lock 파일이 /app에 있다고 가정)
COPY pixi.toml pixi.lock ./
RUN pixi install --frozen

# TinyTeX 설치 (Quarto를 통해)
RUN pixi run quarto install tool tinytex

# ./fonts 폴더를 이미지 내의 폰트 디렉토리로 복사
# 이 경로는 시스템 폰트 경로에 포함되어야 합니다.
COPY ./fonts/ /usr/local/share/fonts/

# 폰트 캐시 업데이트
# 모든 폰트 설치 및 복사 후 한 번만 실행하여 새로 설치된 폰트를 인식하도록 합니다.
RUN fc-cache -fv

# Quarto 프로젝트를 렌더링하는 예시 (컨테이너 시작 시 자동으로 실행)
COPY docs/ ./docs/
CMD cd docs && pixi run quarto render --to pdf
