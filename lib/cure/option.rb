module Cure
  class Option
    require 'optparse'

    attr_accessor :options
    attr_accessor :urls

    def initialize
      @options = {}
      @urls = []
    end

    def evaluate_input
      optparse = OptionParser.new do |opts|
        @options[:verbose] = false
        opts.banner = "Usage: cure [@options] URL(s)"
        opts.on( '-v', '--verbose', 'All info') do
          @options[:verbose] = true
        end

        @options[:global] = true
        opts.on( '-ng', '--nonglobal', 'Don\'t use environment variables') do
          @options[:global] = false
        end

        opts.on( '-u USER', '--user USER', 'Username for cURL') do |u|
          @options[:user] = u
        end

        opts.on( '-p PASS', '--password PASS', 'Password for cURL') do |p|
          @options[:password] = p
        end

        opts.on( '-h HEADER', '--header HEADER', 'Header @options') do |h|
          @options[:header] = h
          #@options[:header]['Content-Type'] = 'application/xml'
        end

        opts.on( '-a PARAMS', '--params PARAMS', 'Params for post') do |p|
          @options[:params] = p
        end

        opts.on( '-b URL', '--base URL', 'Base URL') do |p|
          @options[:base_url] = p
        end

        opts.on( '-m METHOD', '--method METHOD', 'Params for post') do |m|
          @options[:method] = m
        end

        opts.on( '-h', '--help', 'I\'M LOST') do
          puts <<-HELP

Welcome to the cure!
This is a cURL utility that takes managing your header
out of your hands.. finally.
Fill in these envrionment variables:
  * CURE_BASE_URL   # ie. 'http://api.github.com'
  * CURE_USER       # user for API you're curling
  * CURE_PASSWORD   # password for above user
  * CURE_HEADER     #
Then, unless otherwise specified, you can just use the cure
and you only have to specify the things that matter in your
command!

          HELP
          puts opts
        end
      end
      optparse.parse!
      @options[:url] = ARGV.first
      self
    end
  end
end
