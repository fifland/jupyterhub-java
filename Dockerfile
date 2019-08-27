FROM jupyterhub/jupyterhub:latest
MAINTAINER Felix Münscher <felix.muenscher@mni.thm.de>

RUN apt-get update -qq && apt-get install -y build-essential unzip

RUN apt-get install -y openjdk-11-jre \
    openjdk-11-jdk \
    openjdk-11-demo \
    openjdk-11-doc \
    openjdk-11-jre-headless \
    openjdk-11-source

RUN pip install --upgrade pip && \
    pip install jupyter

RUN mkdir java-kernel && \
    cd java-kernel && \
    wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip && \
    unzip ijava-1.3.0.zip && \
    python3 install.py --sys-prefix

RUN mkdir authenticators && \
    git clone https://github.com/jupyterhub/nativeauthenticator.git && \
    pip install -e nativeauthenticator

#RUN git clone https://github.com/SpencerPark/IJava.git && \
#    cd IJava && \
#    chmod u+x gradlew && \
#    ./gradlew installKernel --sys-prefix

ADD . .

EXPOSE 8000

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD ["jupyterhub"]
