FROM golang:latest as builder

WORKDIR /usr/src/app

COPY ./fullcycle /usr/src/app

RUN go build

FROM gruebel/upx:latest as upx
COPY --from=builder /usr/src/app/code /code
RUN upx --best --lzma -o /coderocks /code

FROM scratch
WORKDIR /
COPY --from=upx /coderocks .

ENTRYPOINT ["./coderocks"]
