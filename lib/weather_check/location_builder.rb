class WeatherCheck::LocationBuilder

    def self.build_from_zipcode (zipcode, days = 1) 
        hash = WeatherCheck::Weathercom.get_weather(zipcode, days)
        return nil if hash.length == 0

        hash[:daily_forecasts] = hash[:forecast].map { |f| WeatherCheck::DailyForecast.new(f)}
        hash.delete(:forecast)
        WeatherCheck::Location.new (hash)       
    end
end