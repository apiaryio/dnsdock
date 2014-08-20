package main

import (
	"flag"
	"fmt"
	"log"
	"os"
)

func main() {
	help := flag.Bool("help", false, "Show this message")

	config := NewConfig()

	flag.StringVar(&config.nameserver, "nameserver", config.nameserver, "DNS server for unmatched requests")
	flag.StringVar(&config.dnsAddr, "dns", config.dnsAddr, "Listen DNS requests on this address")
	domain := flag.String("domain", config.domain.String(), "Domain that is appended to all requests")
	environment := flag.String("environment", "", "Optional context before domain suffix")
	flag.StringVar(&config.dockerHost, "docker", config.dockerHost, "Path to the docker socket")
	flag.BoolVar(&config.verbose, "verbose", true, "Verbose output")

	flag.Parse()

	if *help {
		fmt.Fprintf(os.Stderr, "Usage: %s [options]\n", os.Args[0])
		flag.PrintDefaults()
		return
	}

	config.domain = NewDomain(*environment + "." + *domain)

	fmt.Printf("%#v\n", config)

	dnsServer := NewDNSServer(config)
	if err := dnsServer.Start(); err != nil {
		log.Fatal(err)
	}

}