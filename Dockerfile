FROM alpine:latest
MAINTAINER Richard Wang <ricky9wang@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

RUN apk add --no-cache tzdata ca-certificates \
       ffmpeg libmagic python3 \
       tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
       py3-numpy py3-pillow py3-cryptography py3-decorator cairo py3-pip
RUN apk add --no-cache --virtual .build-deps git build-base gcc python3-dev \
    && pip3 install pysocks ehforwarderbot efb-telegram-master efb-wechat-slave \
    && pip3 install git+https://github.com/ehForwarderBot/efb-msg_blocker-middleware \
    && pip3 install git+https://github.com/ehForwarderBot/efb-search_msg-middleware \
    && apk del .build-deps
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
