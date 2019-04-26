class WeatherCheck::CLI

    FORECAST_DAYS = 3
    TABLE_FORMAT = "%-23s %-28s %-28s %-28s"

    def call
        puts "Welcome to Weather Check"       
        forecast_report if create_location_by_zipcode     
        menu
        bye
    end

    def create_location_by_zipcode 
        puts "Enter 5 digit zip code"
        input = gets.strip
        if input.length == 5 && input.to_i && input.to_i.between?(501,99950)
            location = WeatherCheck::LocationBuilder.build_from_zipcode(input, FORECAST_DAYS)
            puts "Zip code not found" if !location
        else
            puts "Invalid Zip Code" 
        end
        defined? location && location 
    end

    def menu
        option = nil
        while option != "exit" 
            puts <<-DOC.gsub /^\s*/, ''
                Options:
                    1. Add Location
                    2. Forecast Report
                    3. Temperature Report
                Enter Option Number or exit
            DOC

            option = gets.strip.downcase
            case option
                when "1"
                    create_location_by_zipcode
                when "2"
                    forecast_report
                when "3"
                    temperature_report
                else
                    puts "Not sure what you want to do! Enter option number or 'exit'" if option != "exit"
            end
        end
    end

    def bye
        puts "Bye!"
    end

    ## Reports 
    def table_header
        dates = WeatherCheck::Location.all.first.forecast_dates     
        puts TABLE_FORMAT % ["Location", dates[0], dates[1], dates[2]]
    end

    # TODO: notice the similarity in the reports?  Maybe generalize with 
    # a callback/yield where caller provides the data for a row in the table?
    def forecast_report
        table_header
        WeatherCheck::Location.all.each { |loc| 
            forecasts = loc.daily_forecasts
            puts TABLE_FORMAT % ["#{loc.name} (#{loc.zipcode})", forecasts[0].description, 
                            forecasts[1].description, forecasts[2].description ]
        }   
    end

    def temperature_report
        table_header
        WeatherCheck::Location.all.each { |loc| 
            forecasts = loc.daily_forecasts
            puts TABLE_FORMAT % ["#{loc.name} (#{loc.zipcode})", 
                "#{forecasts[0].high_temperature}/#{forecasts[0].low_temperature}",
                "#{forecasts[1].high_temperature}/#{forecasts[1].low_temperature}",   
                "#{forecasts[2].high_temperature}/#{forecasts[2].low_temperature}"
            ]
        }   
    end

end