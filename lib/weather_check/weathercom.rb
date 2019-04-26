class WeatherCheck::Weathercom

    WEATHERCOM_URL  = "https://weather.com/weather/tenday/l/"

    def self.get_weather(zipcode, days)
        hash = Hash.new

        begin
            doc = Nokogiri::HTML(open(WEATHERCOM_URL+zipcode))
            title = doc.search("h1").text; 
            hash[:name]=title.split(/\(/).first.strip!
            hash[:zipcode]=zipcode
    
            forecast = []
            days.times do |i|
                f = Hash.new
                f[:date] = doc.search("span.day-detail")[i].text 
                f[:description] = doc.search("td.description")[i].children.text
                temperatures = doc.search("td.temp")[i].children[0]
                f[:high_temperature] = temperatures.children[0].text 
                f[:low_temperature] = temperatures.children[2].text 
                forecast << f
            end
            hash[:forecast] = forecast

        rescue OpenURI::HTTPError => e
            # assume 404 is bad zip code.  Raise errors for everything else
            if e.message != '404 Not Found'
                raise e
            end
        end
        
        hash
    end
end