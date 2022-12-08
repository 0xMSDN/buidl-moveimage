FROM ubuntu:latest@sha256:817cfe4672284dcbfee885b1a66094fd907630d610cab329114d036716be49ba

VOLUME /project
WORKDIR /project

ADD . /move/

#Needed for sccache to function, and to work around home dir being blatted.
ENV CARGO_HOME "/opt/cargo"
ENV RUSTUP_HOME "/opt/rustup"

ENV DOTNET_ROOT "/opt/dotnet"
ENV Z3_EXE "/opt/bin/z3"
ENV CVC5_EXE "/opt/bin/cvc5"
ENV BOOGIE_EXE "/opt/dotnet/tools/boogie"
ENV SOLC_EXE "/opt/bin/solc"
ENV PATH "/opt/cargo/bin:/usr/lib/golang/bin:/opt/bin:${DOTNET_ROOT}:${DOTNET_ROOT}/tools:$PATH"

# Batch mode and all operations tooling
RUN mkdir -p /github/home && \
    mkdir -p /opt/cargo/ && \
    mkdir -p /opt/git/ && \
        sed -i -e 's/\r$//' /move/scripts/*.sh && \
    /move/scripts/dev_setup.sh -t -b -p -y -d -g -n && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /move; cargo build -p move-cli

RUN cd /move; cargo install --path language/move-analyzer

RUN cd /move; cargo install --path language/dove/dove

RUN apt-get update && apt-get install netcat vim openssh-client -y