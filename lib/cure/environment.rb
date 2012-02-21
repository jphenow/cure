module Cure
  class Environment
    PREFIX = 'CURE_'
    attr_accessor :environment
    def initialize(favored = nil)
      @environment = {}
      suffixes = %w{BASE_URL USER PASSWORD HEADER CONFIG}
      suffixes.each do |suffix|
        @environment[suffix.downcase.to_sym] = ENV[PREFIX + suffix]
      end
      @environment[:config] ||= '~/.cure.yml'
      merge!(favored) unless favored.nil?
    end

    private
    def merge!(favored)
      favored.each do |key, value|
        @environment[key] = value unless value.nil?
      end
    end
  end
end
