# python builder
FROM python:3.11 AS py_builder

# Setup python3 virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy and install dependencies
COPY ./requirements.txt . 
RUN pip install -r requirements.txt

# rust builder
FROM rust:bullseye AS rust_builder

RUN git clone https://github.com/denisidoro/navi && cd navi && make install
    

# golang builder
FROM golang:1.24-alpine AS go_builder

ENV GOBIN=/usr/local/bin/
RUN go install github.com/charmbracelet/gum@latest \
    && go install github.com/jesseduffield/lazygit@latest

# Build tools container
FROM quay.io/toolbx-images/debian-toolbox:12

COPY --from=py_builder /opt/venv /opt/venv 
COPY --from=rust_builder /usr/local/cargo/bin/navi /usr/local/bin/navi
COPY --from=go_builder /usr/local/bin/gum /usr/local/bin/gum
COPY --from=go_builder /usr/local/bin/lazygit /usr/local/bin/lazygit

ENV NAVI_PATH=/usr/share/navi/cheats
# Install packages that will be installed at build
RUN apt update -y && apt install --no-install-recommends -y bat curl exa fzf git jq silversearcher-ag wget zoxide \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/denisidoro/cheats /usr/share/navi/cheats \
    && ln -sf /usr/bin/python3 /opt/venv/bin/python3 \
    && ln -s /usr/bin/batcat /usr/local/bin/bat \
