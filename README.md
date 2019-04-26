# WeatherCheck

CLI to view and compare weather forecasts for different locations (by zip code).

## Installation
Environment: Ruby 2.6.1

A gem in progress...  For now
- clone this repo
- bundle install

## Usage

To run, ./bin/weather-check

Follow console prompts

## Implementation Notes

Main source files are in lib/weather_check.
Classes:
* CLI : this is the "view" and "controller".  In handles writing to console, getting user input, and directs input processing.
* Location : a location (zipcode and name) with daily forecasts
* DailyForecast : daily forecast details (date, description, temperature)
* LocationBuilder : Builds a Location object by using a weather resource (Weathercom) to get forecast data
* Weathercom : scraper for weather.com

The app design plays with the Builder pattern.  The LocationBuilder controls the building of a Location.  It uses a weather resource (only 1 right now, so directly calling Weathercom class) to retrieve forecast data.  It then constructs the DailyForecast objects and finally the Location object.

The Location class is a "typical" Ruby model class.   Class variable is used to keep track of all Location objects.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

