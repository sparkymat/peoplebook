package route

import (
	"net/http"

	"github.com/rs/zerolog"
)

type ConfigService interface {
	DatabaseURL() string
	StorageFolder() string
}

func SetupRouter(log zerolog.Logger, cfg ConfigService) (*http.ServeMux, error) {
	router := http.NewServeMux()

	registerWebRoutes(log, router, cfg)

	return router, nil
}
