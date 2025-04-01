package route

import (
	"net/http"

	"github.com/rs/zerolog"
	"github.com/sparkymat/peoplebook/internal/handler"
	"github.com/sparkymat/peoplebook/internal/middleware"
)

func registerWebRoutes(log zerolog.Logger, router *http.ServeMux, _ ConfigService) {
	handleFunc(log, router, "GET /", handler.Home)
}

func handleFunc(log zerolog.Logger, router *http.ServeMux, route string, handlerFunc http.HandlerFunc) {
	handlerFunc = middleware.WrapMiddleware(
		[]middleware.MiddlewareFunc{
			middleware.RequestLogger(log),
		},
		handlerFunc,
	)

	router.HandleFunc(route, handlerFunc)
}
