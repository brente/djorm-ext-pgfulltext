FROM ubuntu:18.04

MAINTAINER Rémy Greinhofer <remy.greinhofer@livelovely.com>

# Create the directory containing the code
RUN mkdir /code
WORKDIR /code

# Set environment variables
ENV PYTHONPATH $PYTHONPATH:/code
ENV DEBIAN_FRONTEND noninteractive

# Update the package list
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    apt-utils \
    software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
    git \
  # Install Python 2.7
    python-minimal \
  # Install Python 3.x
    python3.4 \
    python3.5 \
    python3.6 \
    python3.7 \
    python-pip \
    python3-pip \
  # Install postgresql dev lib.
    libpq-dev \
  # Cleaning up
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize pip cache
RUN pip install -q -U psycopg2-binary tox \
  && pip3 install -q -U psycopg2-binary tox pytest pytest-django \
  && pip3 install -q -U "django>=1.7,<1.8" \
  && pip3 install -q -U "django>=1.8,<1.9" \
  && pip3 install -q -U "django>=1.9,<1.10" \
  && pip3 install -q -U "django>=1.10,<1.11" \
  && pip3 install -q -U "django>=1.11,<1.12" \
  && pip3 install -q -U "django>=2.0,<2.1" \
  && pip3 install -q -U "django>=2.1,<2.2" \
  # && pip install -U "django>=2.2,<2.3" \
  && pip3 uninstall -q -y django psycopg2-binary pytz pytest pytest-django
