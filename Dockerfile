FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    curl \
    python3-pip \
    git

# Install pip for Python 3.10
RUN curl -fsSLO https://bootstrap.pypa.io/get-pip.py \
    && python3.10 get-pip.py \
    && rm get-pip.py



# Install PyYAML
RUN pip3 install PyYAML

COPY feed.py /usr/bin/feed.py 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]



