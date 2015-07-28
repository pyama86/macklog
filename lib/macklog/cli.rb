require 'macklog'

module Macklog
  class Cli < Thor
    desc "check", "check log"
    option :file, :type => :string , :required => true, :aliases => '-f'
    option :critical, :type => :string, :aliases => '-c'
    option :warning, :type => :string, :aliases => '-w'
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
      check_log(file_path, options[:critical], 2, options[:ignorecase]) if options[:critical]
      check_log(file_path, options[:warning], 1, options[:ignorecase]) if options[:warning] 
    end
    default_task :check
    no_tasks do
      def check_log(file_path, word, status, ignore)
        result = log_search(file_path, word, ignore)
        exit_status status if result && !notified?(file_path, result)
      end

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
        tmp_path = ENV["MACKLOG_TMP"] ? ENV["MACKLOG_TMP"] : "/tmp"
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
          when 1
            raise(Macklog::Warning)
          when 2
            raise(Macklog::Critical)
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
