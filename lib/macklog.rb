require 'thor'
require 'pp'
require "macklog/version"
require "macklog/cli"

module Macklog
  class Error < StandardError; end
  class FileNotFound < Error; end
  class Critical < Error; end
  class Warning < Error; end
end
