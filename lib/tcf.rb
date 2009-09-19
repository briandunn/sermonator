class TCF
  DOMAIN   = 'tcf.theophil.us'
  PASSWORD = 'TCF@|_|D!0'

  attr_accessor :date, :title, :author, :infile, :full_title, :file_name

  def domain
    TCF::DOMAIN
  end

  def password
    TCF::PASSWORD
  end

  def initialize( date, title, author, infile )
    @date = date
    @title = title.strip
    @author = author.strip
    @infile = infile
    @full_title = "#{date} ~ #{title}"
    @file_name = full_title + '.mp3' 
  end

  def compress
    `lame -b 48 -m m --ty #{date.year} --tt "#{full_title}" --tl "TCF Sermons" --ta "#{author}" --tn 0 --tg 101 "#{infile}" "#{file_name}"`
  end

  def upload
    total_sent = 0
    absolute_file_name = File.join(Dir.getwd,file_name)
    file_size = File.size(absolute_file_name).to_f
    Net::FTP.open(domain) do |ftp|
      ftp.login('tcfaudio', password )
      ftp.chdir("#{domain}/media")
      ftp.putbinaryfile(absolute_file_name) do |data|
        puts "uploaded % #{( ( ( total_sent += Net::FTP::DEFAULT_BLOCKSIZE ) / file_size.to_f ) * 100 ).round} "
      end
    end
  end

  def utc_date 
    Time.local(date.year, date.month, date.day ).getgm
  end

  def post
    uri = "http://#{domain}"
    content = <<-CONTENT
    [podcast]#{uri}/media/#{URI.escape(file_name)}[/podcast]
    CONTENT
    content = Blog::Client::Content.new( :title => title, :dateCreated => utc_date, :mt_keywords => [author], :description => content ) 
    Blog::Client.new("#{uri}/xmlrpc.php", :not_used, 'admin', password).metaWeblog_newPost(:not_used,content,false)
  end

end
