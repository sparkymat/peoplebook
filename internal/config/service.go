package config

import (
	"fmt"
	"net/url"

	"github.com/caarlos0/env/v11"
)

func New(version string) (*Service, error) {
	var envValues envValues

	err := env.Parse(&envValues)
	if err != nil {
		return nil, fmt.Errorf("failed to load config from env. err: %w", err)
	}

	return &Service{
		version:   version,
		envValues: envValues,
	}, nil
}

type Service struct {
	version   string
	envValues envValues
}

type envValues struct {
	DatabaseName     string `env:"DATABASE_NAME,required"`
	DatabaseHostname string `env:"DATABASE_HOSTNAME,required"`
	DatabasePort     string `env:"DATABASE_PORT,required"`
	DatabaseUsername string `env:"DATABASE_USERNAME"`
	DatabasePassword string `env:"DATABASE_PASSWORD"`
	DatabaseSSLMode  bool   `env:"DATABASE_SSL_MODE"             envDefault:"true"`
	RedisURL         string `env:"REDIS_URL,required"`
	StorageFolder    string `env:"STORAGE_FOLDER,required"`
}

func (s *Service) Version() string {
	return s.version
}

func (s *Service) DatabaseURL() string {
	connString := "postgres://"

	if s.envValues.DatabaseUsername != "" {
		connString = fmt.Sprintf("%s%s", connString, s.envValues.DatabaseUsername)

		if s.envValues.DatabasePassword != "" {
			encodedPassword := url.QueryEscape(s.envValues.DatabasePassword)
			connString = fmt.Sprintf("%s:%s", connString, encodedPassword)
		}

		connString += "@"
	}

	sslMode := "disable"
	if s.envValues.DatabaseSSLMode {
		sslMode = "require"
	}

	connString = fmt.Sprintf(
		"%s%s:%s/%s?sslmode=%s",
		connString,
		s.envValues.DatabaseHostname,
		s.envValues.DatabasePort,
		s.envValues.DatabaseName,
		sslMode,
	)

	return connString
}

func (s *Service) RedisURL() string {
	return s.envValues.RedisURL
}

func (s *Service) StorageFolder() string {
	return s.envValues.StorageFolder
}
