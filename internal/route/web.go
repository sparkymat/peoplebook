package route

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/sparkymat/peoplebook/internal/handler"
)

func registerWebRoutes(app *echo.Group, cfg ConfigService) {
	webApp := app.Group("")

	webApp.Use(middleware.CSRFWithConfig(middleware.CSRFConfig{
		TokenLookup: "form:csrf",
	}))

	webApp.GET("/", handler.Home())
}
