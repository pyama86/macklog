require 'thor'
require 'pp'
require "macklog/version"
require "macklog/cli"

module Macklog
  class Error < StandardError; end
  class FileNotFound < Error; end
  class MatchWord < Error; end
end
