FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29

COPY texlive.profile /tmp

ENV PATH /usr/local/texlive/2019/bin/x86_64-linuxmusl:${PATH}
ENV TEXLIVE_URL http://mirror.ctan.org/systems/texlive/tlnet
 
RUN apk --no-cache add libx11 libxext libxrender libstdc++ freetype fontconfig libssl1.1 perl wget

RUN apk --no-cache add --virtual install-dependencies xz tar && \
    mkdir /tmp/install-tl-unx && \
    cd /tmp/install-tl-unx && \
    wget ${TEXLIVE_URL}/install-tl-unx.tar.gz && \
    tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
    ./install-tl --repository ${TEXLIVE_URL} --profile=/tmp/texlive.profile && \
    cd /root && \
    rm -rf /tmp/install-tl-unx && \
    tlmgr install ec fontawesome latexmk && \
    apk del install-dependencies
