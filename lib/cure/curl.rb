module Cure
  class Curl
    require 'patron'

    def initialize(options = {})
      @options = options
      @sess = Patron::Session.new
      @sess.base_url = @options[:base_url]
      @sess.timeout = 10
      @options[:header].each do |key, value|
        @sess.headers[key.to_s] = value
      end unless @options[:header].nil?
      ensure_valid
      self
    end

    def run
      case @options[:method]
      when "put", "delete", "post"
        response = @sess.send @options[:method], @options[:url], @options[:params]
      when "get", "head"
        response = @sess.send @options[:method], @options[:url]
      end
      puts response.headers if @options[:verbose]
      puts response.body
    end

    def ensure_valid
      param_methods = %w{delete post put}
      methods = %w{get head} + param_methods
      if not methods.include? @options[:method]
        abort "Not an acceptable method"
      end
      if @options[:url].nil?
        abort "URL required"
      end
      if @options[:base_url].nil?
        abort "Base URL required"
      end
      if param_methods.include? @options[:method] and @options[:params].nil?
        abort "Parameters required for #{param_methods.to_s}"
      end
    end
  end
end
