class WeatherstackApi
  def self.get_weather(city)
    url = "http://api.weatherstack.com/current?access_key=#{ENV.fetch('WEATHERSTACK_APIKEY', nil)}&query=#{city}"
    response = HTTParty.get(url)
    response.parsed_response
  end

  def self.get_weather_in(city)
    Rails.cache.fetch(city, expires_in: 1.day) { get_weather(city) }
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
