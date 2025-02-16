FROM python:3.11 AS builder1

# Setup python3 virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy and install dependencies
COPY ./requirements.txt . 
RUN pip install -r requirements.txt

FROM rust:1.67-bullseye AS builder2

RUN git clone https://github.com/denisidoro/navi && cd navi && make install

# Build tools container
FROM quay.io/toolbx-images/debian-toolbox:12

COPY --from=builder1 /opt/venv /opt/venv 
COPY --from=builder2 /usr/local/cargo/bin/navi /usr/local/bin/navi

ENV NAVI_PATH=/usr/share/navi/cheats
# Install packages that will be installed at build
RUN apt update -y && apt install --no-install-recommends -y bat curl exa fzf git jq silversearcher-ag wget zoxide \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/denisidoro/cheats /usr/share/navi/cheats \
    && ln -sf /usr/bin/python3 /opt/venv/bin/python3 \
    && ln -s /usr/bin/batcat /usr/local/bin/bat \
