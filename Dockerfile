FROM ubuntu

COPY . /root

WORKDIR /root

RUN ./install.sh

CMD ["sh", "-c", "fish"]
