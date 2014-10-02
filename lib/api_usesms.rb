require 'uri'
require 'net/http'
module UseSms
	class << self
    attr_accessor :user
    attr_accessor :password
  end
  @@user = nil
  @@password = nil

  api_path = "http://usesms.net.br/api"

	def self.setup
    yield self
  end

  def self.token
  	uri = URI("http://usesms.net.br/api/autenticar/#{UseSms.user}/#{UseSms.password}")
  	Net::HTTP.get(uri)
  end

  def self.status(id)
  	uri = URI("http:://usesms.net.br/api/status/#{self.token}/#{id}")
  	Net::HTTP.get(uri)
  end


  def self.send(phone,msg)
		token = self.token
		msg = URI.escape(msg)
		uri = URI("http://usesms.net.br/api/envia_sms/#{token}/#{phone}/#{msg}")
  	puts uri
		Net::HTTP.get(uri)
	end

  def self.credits
    token = self.token
    uri = URI("#{api_path}/saldo/#{token}")
    Net::HTTP.get(uri)
  end

  def self.ping
    token = self.token
    uri = URI("#{api_path}/ping/#{token}")
    Net::HTTP.get(uri)
  end

end
