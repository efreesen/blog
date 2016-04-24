#!/usr/bin/env puma

environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/run/efreesen/puma.pid"
stdout_redirect "/var/log/puma/stdout.log", "/var/log/puma/stderr.log"

threads 0, 16

bind "unix:///var/run/puma/puma.sock"
Raw
