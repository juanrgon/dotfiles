FROM ubuntu

COPY . /root/github.com/juanrgon/dotifles

WORKDIR /root/github.com/juanrgon/dotifles

RUN ./install.sh

WORKDIR /

CMD ["sh", "-c", "fish"]
