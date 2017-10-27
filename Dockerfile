# Build container
FROM golang:alpine AS build-go
RUN apk --no-cache add git build-base ca-certificates wget perl gmp-dev
RUN wget -v http://www.shoup.net/ntl/ntl-10.5.0.tar.gz
RUN gunzip ntl-10.5.0.tar.gz
RUN tar xf ntl-10.5.0.tar
RUN cd ntl-10.5.0/src && ./configure && make && make check && make install
ENV D=/go/src/github.com/nikofil/helib-go
ADD . $D
RUN cd $D/src && make fhe.so && cp fhe.so /usr/lib/x86_64-linux-gnu/libfhe.so
RUN cd $D && go build fhe.go
RUN cd $D && go test
