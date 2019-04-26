class WeatherCheck::DailyForecast 

    VALID_PARAMS = [ :date, :description, :high_temperature, :low_temperature ]

    attr_accessor :date, :description, :high_temperature, :low_temperature

    def initialize(**params)
        params.each do |key, value|
            raise "Unknown option #{key.inspect}" unless (VALID_PARAMS.include?(key))
            instance_variable_set("@#{key}", value)
        end
    end

end