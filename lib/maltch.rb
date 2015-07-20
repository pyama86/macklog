require 'thor'
require 'pp'
require "maltch/version"
require "maltch/cli"

module Maltch
  class Error < StandardError; end
  class FileNotFound < Error; end
  class MatchWord < Error; end
end
