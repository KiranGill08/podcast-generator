FROM ubuntu:latest

# Install required packages and Python 3.10
RUN apt-get update && apt-get install -y \
    python3.10 \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.10 /usr/bin/python || true

# Install pip for Python 3.10
RUN curl -fsSLO https://bootstrap.pypa.io/get-pip.py \
    && python3.10 get-pip.py \
    && rm get-pip.py

# Ensure that `pip` is available as `pip3` for Python 3.10
RUN ln -s /usr/local/bin/pip /usr/local/bin/pip3

# Install PyYAML
RUN pip3 install PyYAML

# Copy application files
COPY feed.py /usr/bin/feed.py 
COPY entrypoint.sh /entrypoint.sh

# Ensure entrypoint script has execution permissions
RUN chmod +x /entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
