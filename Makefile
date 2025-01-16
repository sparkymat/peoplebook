all: peoplebook

LDFLAGS=-ldflags "-X main.Version=${GITHUB_REF} -s -w -extldflags \"-static\""

peoplebook:
	CGO_ENABLED=0 go build ${LDFLAGS} -o peoplebook main.go

start-app:
	# Install reflex with 'go install github.com/cespare/reflex@latest'
	# Install godotenv with 'go install github.com/joho/godotenv/cmd/godotenv@latest'
	reflex -s -r '\.go$$' -- godotenv -f .env go run main.go

start-view:
	# Install reflex with 'go install github.com/cespare/reflex@latest'
	reflex -r '\.templ$$' -- templ generate

db-migrate:
	migrate -path migrations -database "postgres://127.0.0.1/peoplebook?sslmode=disable" up

db-schema-dump:
	pg_dump --schema-only -O peoplebook > internal/database/schema.sql

sqlc-gen:
	sqlc generate

.PHONY: peoplebook start-app start-view db-migrate db-schema-dump sqlc-gen
