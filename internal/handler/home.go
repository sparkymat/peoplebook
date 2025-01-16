package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/rs/zerolog/log"
	"github.com/sparkymat/peoplebook/internal/view"
)

func Home() echo.HandlerFunc {
	return func(c echo.Context) error {
		csrfToken := getCSRFToken(c)
		if csrfToken == "" {
			log.Warn().Msg("error: csrf token not found")

			return c.String(http.StatusInternalServerError, "server error")
		}

		pageHTML := view.Home()
		document := view.Layout("peoplebook", csrfToken, pageHTML)

		return Render(c, http.StatusOK, document)
	}
}
