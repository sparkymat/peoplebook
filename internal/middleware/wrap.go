package middleware

import "net/http"

type MiddlewareFunc func(next http.HandlerFunc) http.HandlerFunc

func WrapMiddleware(middlewares []MiddlewareFunc, handler http.HandlerFunc) http.HandlerFunc {
	for _, middleware := range middlewares {
		handler = middleware(handler)
	}

	return handler
}
