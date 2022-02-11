class MapquestService

  def self.route(location1, location2)
    call_api("/directions/v2/route?from=#{location1}&to=#{location2}")
  end

  def self.call_api(path)
    response = conn.get(path)
    parse(response)
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com", params: { key: ENV['MAPQUEST_API_KEY'] })
  end
end
