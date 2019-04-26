require 'nokogiri'
require 'open-uri'
#require 'pry'

require_relative "weather_check/version"

require_relative "weather_check/cli.rb"
require_relative "weather_check/location.rb"
require_relative "weather_check/location_builder.rb"
require_relative "weather_check/daily_forecast.rb"
require_relative "weather_check/weathercom.rb"