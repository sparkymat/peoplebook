package route

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type ConfigService interface {
	DatabaseURL() string
	StorageFolder() string
}

func Setup(e *echo.Echo, cfg ConfigService) {
	e.GET("/health", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	app := e.Group("")
	app.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Format: "[${time_rfc3339}] Got ${method} on ${uri} from ${remote_ip}. Responded with ${status} in ${latency_human}.\n",
	}))
	app.Use(middleware.Recover())

	registerWebRoutes(app, cfg)
}
