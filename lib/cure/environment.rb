module Cure
  class Environment
    attr_accessor :suffixes
    def initialize(favored = nil)
      suffixes = %w{BASE_URL USER PASSWORD HEADER CONFIG}
      merge!(favored) unless favored.empty?
    end

    def prefix
      'CURE_'
    end

    def suffixes=(array)
      @suffixes = @suffixes & array
      @suffixes.each do |suffix|
        attribute = suffix.downcase.to_sym
        attr_accessor attribute
        send "#{attribute}=", ENV[prefix + suffix.to_s]
      end
      self.config ||= '~/.cure.yml'
    end

    private
    def merge!(favored)
      favored.each do |key, value|
        send "#{key.downcase.to_s}=", value unless value.nil?
      end
    end
  end
end
