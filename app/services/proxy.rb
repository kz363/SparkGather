require 'net/http'
class Proxy

  def self.check_proxy(user_ip_address)
    url = "http://winmxunlimited.net/api/proxydetection/v1/query/?ip=#{user_ip_address}"
    result = Net::HTTP.get_response(URI.parse(url)).body
  end
end
