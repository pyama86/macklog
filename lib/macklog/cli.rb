require 'macklog'

module Macklog
  class Cli < Thor
    desc "check", "check log"
    option :file, :type => :string , :required => true, :aliases => '-f'
    option :word , :type => :string , :required => true, :aliases => '-w'
    option :ignorecase , :type => :boolean, :aliases => '-i'
    def check
      # exit code
      # 0:OK
      # 1:WARNING
      # 2:CRITICAL
      # 3:UNKNOWN
     
      file_path = File.expand_path(options[:file])

      unless File.exist?(file_path)
        puts "#{file_path} not found!"
        exit_status 3
      end
      
      result = log_search(file_path, options[:word] , options[:ignorecase])
      
      if result && !notified?(file_path, result)
        exit_status 2
      end
    end
    default_task :check
    no_tasks do
      def log_search(file_path, word, ignore=nil)
        result = case
        when ignore
          File.readlines(file_path).grep(/#{word}/i)
        else 
          File.readlines(file_path).grep(/#{word}/)
        end
        result.last.chomp unless result.empty?
      end

      def notified?(file_path, record)
        tmp_path = ENV["macklog_tmp"] ? ENV["macklog_tmp"] : "/tmp"
        tmp_path << "/macklog_#{File.basename(file_path, '.*')}.tmp"

        unless File.exist?(tmp_path) && File.readlines(tmp_path).map(&:chomp).include?(record)
          append_alert_log(tmp_path, record)
          false
        else
          true
        end
      end

      def append_alert_log(tmp_path, record)
        File.open(tmp_path, "a") do |file|
          file.puts record
        end
      end

      def exit_status(status)
        if ENV["MALTCH_TEST"]
          case status
          when 2
            raise(Macklog::MatchWord)
          when 3
            raise(Macklog::FileNotFound)
          else
            true
          end
        else
          exit(status)
        end
      end
    end
  end
end
