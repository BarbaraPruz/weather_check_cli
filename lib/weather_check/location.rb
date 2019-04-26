class WeatherCheck::Location
    @@all = []

    attr_accessor :zipcode, :name, :daily_forecasts
    VALID_PARAMS = [ :zipcode, :name, :daily_forecasts]

    def initialize (params)
        params.each do |key, value|
            raise "Unknown option #{key.inspect}" unless (VALID_PARAMS.include?(key))
            instance_variable_set("@#{key}", value)
        end
        @@all << self
    end

    def forecast_dates
        @daily_forecasts.map { |f| f.date }
    end

    def self.all
        @@all
    end
end
