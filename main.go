package main

import (
	"net/http"
	"os"
	"time"

	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/sparkymat/peoplebook/internal/config"
	"github.com/sparkymat/peoplebook/internal/database"
	"github.com/sparkymat/peoplebook/internal/route"
)

var Version = "development"

func main() {
	cfg, err := config.New(Version)
	if err != nil {
		panic(err)
	}

	dbDriver, err := database.New(cfg.DatabaseURL())
	if err != nil {
		log.Error().Msg(err.Error())
		panic(err)
	}

	if err = dbDriver.AutoMigrate(); err != nil {
		log.Error().Msg(err.Error())
		panic(err)
	}

	zl := zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: time.RFC3339}
	// zl.FormatLevel = func(i interface{}) string {
	// 	return strings.ToUpper(fmt.Sprintf("| %-6s|", i))
	// }
	// zl.FormatMessage = func(i interface{}) string {
	// 	return fmt.Sprintf("***%s****", i)
	// }
	// zl.FormatFieldName = func(i interface{}) string {
	// 	return fmt.Sprintf("%s:", i)
	// }
	// zl.FormatFieldValue = func(i interface{}) string {
	// 	return strings.ToUpper(fmt.Sprintf("%s", i))
	// }

	log := zerolog.New(zl).With().Timestamp().Logger()

	router, err := route.SetupRouter(log, cfg)
	if err != nil {
		log.Error().Msg(err.Error())
		panic(err)
	}

	server := http.Server{
		Addr:    ":8080",
		Handler: router,
	}

	log.Info().Msg("Starting server on port :8080")

	if err := server.ListenAndServe(); err != nil {
		panic(err)
	}
}
