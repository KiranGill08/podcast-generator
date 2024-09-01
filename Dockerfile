FROM ubuntu:latest

# Update and install prerequisites
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    build-essential \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Add the deadsnakes PPA for Python 3.10
RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# Install Python 3.10
RUN apt-get install -y python3.10 python3.10-distutils

# Ensure python3 points to python3.10
RUN ln -s /usr/bin/python3.10 /usr/bin/python3 || true

# Install pip for Python 3.10
RUN curl -fsSLO https://bootstrap.pypa.io/get-pip.py \
    && python3.10 get-pip.py \
    && rm get-pip.py

# Install PyYAML
RUN pip3 install --upgrade pip \
    && pip3 install PyYAML

# Copy application files
COPY feed.py /usr/bin/feed.py 
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
