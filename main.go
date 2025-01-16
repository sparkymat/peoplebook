package main

import (
	"os"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/sparkymat/peoplebook/internal/config"
	"github.com/sparkymat/peoplebook/internal/database"
	"github.com/sparkymat/peoplebook/internal/route"
	"github.com/ziflex/lecho/v3"
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

	e := echo.New()

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

	e.Logger = lecho.From(log.Output(zl))

	route.Setup(e, cfg)

	e.Logger.Panic(e.Start(":8080"))
}
