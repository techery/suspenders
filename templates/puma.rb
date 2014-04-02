#!/usr/bin/env puma

# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#timeout

workers (ENV['PUMA_WORKERS'] || 3).to_i
threads (ENV['MIN_THREADS']  || 1).to_i, (ENV['MAX_THREADS'] || 16).to_i

preload_app!

rackup      DefaultRackup
port        ENV['PORT'].to_i || 3000
environment ENV['RACK_ENV']  || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
