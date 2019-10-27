FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive
ARG PIP_NO_CACHE_DIR=0

RUN \
    # Update the Ubuntu package index
       apt-get update \
    # Install the required Ubuntu packages
    && apt-get install -y \
        fontconfig \
        python-pip \
    # Remove the APT cache to reduce Docker image size
    && rm -rf /var/lib/apt/lists/* \
    # Install Pipenv
    && pip install pipenv

WORKDIR /app

# Install the required Python packages
COPY Pipfile Pipfile.lock ./
RUN pipenv install --deploy --system

ENTRYPOINT ["make"]
