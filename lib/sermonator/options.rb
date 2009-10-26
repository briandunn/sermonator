class Sermonator
  class Options < Hash
          attr_reader :opts, :orig_args

      def initialize(args)
        super()

        self[:date] = Date.today
        @orig_args = args.clone

        @opts = OptionParser.new do |o|
          o.banner = "Usage: #{File.basename($0)} [options] audio_file_name\ne.g. #{File.basename($0)} --author 'Brian Dunn' --title 'Why Real Christians Use Macs' sermon.wav"

          o.on('-t', '--title', :REQUIRED, 'set the title') do |title|
            self[:title] = title
          end

          o.on('-a', '--author', :REQUIRED, 'set the author') do |author|
            self[:author] = author
          end

          o.on('-p', '--password', :REQUIRED, 'the password for blog and ftp') do |password|
            self[:password] = password
          end

          o.accept( Date, /^\d{4}-\d{2}-\d{2}$/ ) do |date|
            Date.parse(date)
          end
          o.on('-d', '--date', :OPTIONAL, Date, 'set the date. today by default.') do |date|
            self[:date] = date
          end

          o.on_tail('-h', '--help', 'display this help and exit') do
            self[:show_help] = true
          end
        end

        begin
          @opts.parse!(args)
        rescue OptionParser::InvalidOption => e
          self[:invalid_argument] = e.message
        end
      end

      def valid_options?
        missing_options.blank?
      end

      def missing_options
        %w{ infile password title author }.map do |opt|
          self[opt]
        end.select!(&:blank?)
      end

      def merge(other)
        self.class.new(@orig_args + other.orig_args)
      end

  end
end
