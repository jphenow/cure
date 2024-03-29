module Cure
  class Curl
    def initialize(options = {})
      @options = Options.new(options)
      @session = Patron::Session.new
      @session.base_url = @options.base_url
      @session.timeout = 10
      [:username, :password].each do |e|
        @session.send(eq(e), options.send(e)) if option.send e
      end
      @options.header.each { |key, value| @session.headers[key.to_s] = value } unless @options.header.nil?
      ensure_valid
      self
    end

    def run
      case @options.http_method
      when "put", "delete", "post"
        response = @session.send @options.http_method, @options.url, @options.params
      when "get", "head"
        response = @session.send @options.http_method, @options.url
      end
      puts response.headers if @options.verbose
      puts response.body
    end

    private

    def ensure_valid
      param_methods = %w{delete post put}
      methods = %w{get head} + param_methods
      if not methods.include? @options.http_method
        abort "Not an acceptable method"
      end
      if @options.url.nil?
        abort "URL required"
      end
      if @options.base_url.nil?
        abort "Base URL required"
      end
      if param_methods.include? @options.http_method and @options.params.nil?
        abort "Parameters required for #{param_methods.to_s}"
      end
    end

    def eq(x)
      (x.to_s << "=").to_sym
    end
  end
end
