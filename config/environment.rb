require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'json'

# get the path of the root of the app
APP_ROOT = File.expand_path("..", __dir__)
SENSITIVE_DATA = JSON.parse(File.read('sensitive_data.json'))
# require the model(s)
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }
# require lib directory
Dir.glob(["#{File.join(APP_ROOT)}/lib/**/*.rb"]).each do |file| 
	next if file == "#{APP_ROOT}/lib/app.rb"
	require file 
end

# configure Scraperio settings
class Scraperio < Sinatra::Base
	set :method_override, true
	set :root, APP_ROOT
end

require File.join(APP_ROOT, 'config/database')