FROM ubuntu:14.04

MAINTAINER Rémy Greinhofer <remy.greinhofer@livelovely.com>

# Create the directory containing the code.
RUN mkdir /code
WORKDIR /code

# Set the environment variables.
ENV PYTHONPATH $PYTHONPATH:/code

# Update the package list.
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
  # Install Python2.x.
    python \
    # python-dev \
    python-pip \
  # Install Python 3.5 and 3.6
    python3.5 \
    # python3.6 \
    # python3-dev \
    python3-pip \
  # Install postgresql dev lib.
    libpq-dev \
#  && pip install -q -U tox \
#  && pip3 install -q -U tox \
   && pip install -q -U pip setuptools wheel tox \
   && pip3 install -q -U pip setuptools wheel tox \
  # Cleaning up.
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
