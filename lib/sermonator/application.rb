class Sermonator
  class Application
    class << self
      def run!(*arguments)

        options = Options.new(arguments)

        # must supply a file name
        unless arguments.size == 1
          $stderr.puts options.opts
          return 1
        end
        input_file_name = arguments.first

        if options[:invalid_argument]
          $stderr.puts options[:invalid_argument]
          options[:show_help] = true
        end

        if options[:show_help]
          $stderr.puts options.opts
          return 1
        end

        sermonator = Sermonator.new( input_file_name, options )
        sermonator.compress if options[:compress]
        sermonator.upload   if options[:upload]
        sermonator.post     if options[:post]
      end
    end
  end
end
