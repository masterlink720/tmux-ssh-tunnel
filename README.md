## Synopsis

Small project that sets up a client to persistently and relentely open an SSH connectino to a server, with an SSH port forwarded back

## Code Example

Show what the library does as concisely as possible, developers should be able to figure out **how** your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.

## Motivation

Allows exposing servers on a private network to accept SSH connections via a proxy

## Installation

* Setup the configuration values in client/config
* On the server, run server/install.sh __You MUST do this first!__
* On the client, likewise run client/install.sh

## API Reference

The only requirement is two linux servers, __One of which MUST be accessible through the public internet__

tmux and ssh are the only software requirements, however if you don't have them the script will attempt to instal lthis

This has only been tested on:

* Ubuntu / Debian
* Fedora

## Contributors

* [Brandon Simmons](mailto:brandon@binarybeast.com)

## License

Licensed under the WfffFPL