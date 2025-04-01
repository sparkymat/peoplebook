package handler

import (
	"net/http"

	"github.com/sparkymat/peoplebook/internal/view"
)

func Home(w http.ResponseWriter, r *http.Request) {
	pageHTML := view.Home()
	document := view.Layout("peoplebook", "", pageHTML)

	Render(w, r, http.StatusOK, document)
}
