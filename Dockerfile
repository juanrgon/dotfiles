FROM ubuntu

COPY . /root/github.com/juanrgon/dotifles

WORKDIR /root/github.com/juanrgon/dotifles

RUN ./install.sh

RUN rm -rf ./git

CMD ["sh", "-c", "fish"]
