class WeatherCheck::LocationBuilder

    def self.build_from_zipcode (zipcode, days = 1) 
        # Right now, we only have one weather provider resource (weather.com scraper)
        # If multiple weather provider resources, each would need to know the hash keys.
        # So the hash keys are sort of a contract for a weather provider resource
        # Alternatively, the weather provider could have specific methods
        # to retrieve high temperature for a date, description for a date, etc.
        hash = WeatherCheck::Weathercom.get_weather(zipcode, days)
        return nil if hash.length == 0

        hash[:daily_forecasts] = hash[:forecast].map { |f| WeatherCheck::DailyForecast.new(f)}
        hash.delete(:forecast)
        WeatherCheck::Location.new (hash)       
    end
end