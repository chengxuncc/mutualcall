package main

import (
	"log"
	"time"

	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(400, 600),
	flutter.AddPlugin(&Greeting{}),
}

type Greeting struct {
	channel *plugin.MethodChannel
}

func (p *Greeting) InitPlugin(messenger plugin.BinaryMessenger) error {
	p.channel = plugin.NewMethodChannel(messenger, "example.com/greeting", plugin.StandardMethodCodec{})
	p.channel.HandleFunc("say", p.hi)
	return nil
}

func (p *Greeting) hi(arguments interface{}) (reply interface{}, err error) {
	go func() {
		time.Sleep(time.Second)
		if rep,err := p.channel.InvokeMethodWithReply("say2", "hello from golang"); err != nil {
			log.Println("InvokeMethod error:", err)
		}else {
			log.Println(rep)
		}
	}()

	log.Println(arguments)
	return "hi from golang", nil
}
