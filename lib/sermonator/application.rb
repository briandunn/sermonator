class Sermonator
  class Application
    class << self
      def run!(*arguments)
        options = Options.new(arguments)
        if options[:invalid_argument]
          $stderr.puts options[:invalid_argument]
          options[:show_help] = true
        end

        if options[:show_help]
          $stderr.puts options.opts
          return 1
        end


      end
    end
  end
end
