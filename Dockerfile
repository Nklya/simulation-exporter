FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY src/go.mod src/go.sum ./
RUN go mod download
COPY src/*.go ./
RUN CGO_ENABLED=0 go build -o /app/simulation-exporter

# FINAL IMAGE
FROM alpine:3.22 AS alpine

WORKDIR /app
COPY --from=builder /app/simulation-exporter /app/simulation-exporter
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
USER 1000
EXPOSE     8080
ENTRYPOINT ["/app/simulation-exporter"]
