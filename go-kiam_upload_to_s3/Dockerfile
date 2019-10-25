FROM golang:1.13

WORKDIR /go/src/kiamexample
COPY ./src .

RUN go get -d .
RUN go build -o bin/kiamexample main.go

ENTRYPOINT [ "/go/src/kiamexample/bin/kiamexample"]