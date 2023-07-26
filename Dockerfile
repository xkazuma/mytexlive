FROM texlive/texlive:TL2022-historic

MAINTAINER xkzmdev<xkzm.dev@gmail.com>

# Build-args: UID=$(id -u) GID=$(id -g)
ARG UID
ARG GID

# Installing PDF viewer 
RUN apt-get update -y \
 && apt-get install -y \
      qpdfview 

# Updating texlive, and installing font collections for Japanese
RUN tlmgr option repository ftp://tug.org/texlive/historic/2022/tlnet-final/ \
 && tlmgr update --all \
 && tlmgr install latexmk \ 
                  collection-langjapanese \
                  collection-fontsrecommended \
                  collection-fontutils \
                  collection-latexextra \
 && luaotfload-tool -v -vvv -u

WORKDIR /workspace

# Creating a user named latex and a group named latex
RUN groupadd -g ${GID} latex \
 && useradd -m -s /bin/bash -u ${UID} -g ${GID} latex 
RUN chown -R latex:latex /workspace 

# Copying a setting file for latexmk
COPY ./config/latexmkrc-qpdfview /home/latex/.latexmkrc
# Copying a setting file for qpdfview
COPY ./config/qpdfview /home/latex/.config/qpdfview

USER latex

