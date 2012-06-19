module Cure
  class Environment
    extend Cure::Accessorizer

    def self.suffixes
      %w{VERBOSE METHOD GLOBAL BASE_URL USER PASSWORD HEADER CONFIG}
    end

    def self.attrs
      vals = suffixes.collect { |s| ENV[prefix + s] }
      Hash[*suffixes.zip(vals).flatten]
    end

    def self.prefix
      'CURE_'
    end

    def self.config
      self.config ||= '~/.cure.yml'
    end

    accessorize Environment.attrs
  end
end
