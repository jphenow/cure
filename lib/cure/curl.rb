module Cure
  class Curl
    require 'patron'

    def initialize(options = {})
      @options = options
      @sess = Patron::Session.new
      @sess.base_url = options[:base_url]
      @sess.timeout = 10
      options[:header].each do |key, value|
        @sess.headers[key.to_s] = value
      end unless options[:header].nil?
    end

    def run
      case @options[:method]
      when "put", "delete", "post"
        response = @sess.send @options[:method], @options[:url], @options[:params]
      when "get", "head"
        response = @sess.send @options[:method], @options[:url]
      end
      response.headers
      response.body
    end
  end
end
