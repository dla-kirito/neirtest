package cmd

import (
	"context"
	"net/http"
	_ "net/http/pprof"
	"time"

	_ "code.byted.org/lidar/agent/init"
	"go.uber.org/fx"

	"code.byted.org/vecode/vecode/util/conf"
)

func profilerModule(target buildTarget) fx.Option {
	opts := []fx.Option{}
	if target == BuildTargetWorker {
		opts = append(opts,
			fx.Provide(newProfilerServer),
			fx.Invoke(startProfilerServer),
		)
	}
	return fx.Options(opts...)
}

func newProfilerServer() *http.Server {
	debugAddr := conf.GlobalConfig().Worker.PprofDebugAddr
	return &http.Server{
		Addr: debugAddr,
	}
}

func startProfilerServer(lc fx.Lifecycle, server *http.Server) {
	lc.Append(fx.Hook{
		OnStart: func(ctx context.Context) error {
			errChan := make(chan error, 1)
			go func() {
				errChan <- server.ListenAndServe()
			}()
			select {
			case err := <-errChan:
				return err
			case <-time.After(5 * time.Second):
				return nil
			}
		},
		OnStop: func(ctx context.Context) error {
			return server.Close()
		},
	})
}
