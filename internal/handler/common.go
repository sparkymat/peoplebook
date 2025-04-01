package handler

import (
	"net/http"

	"github.com/a-h/templ"
)

func Render(w http.ResponseWriter, r *http.Request, statusCode int, t templ.Component) {
	buf := templ.GetBuffer()
	defer templ.ReleaseBuffer(buf)

	if err := t.Render(r.Context(), buf); err != nil {
		w.Header().Add("Content-Type", "text/html")
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte("failed"))

		return
	}

	w.Header().Add("Content-Type", "text/html")
	w.WriteHeader(statusCode)
	w.Write(buf.Bytes())
}
