#!/usr/bin/env ruby
# == Synopsis
#
# tcf-encode: encodes a sermon for upload to the TCF podcast. 
#
# == Usage
#
# tcf-encde -a "Brian Dunn" -t "Why Real Christians Use Macs" <infile> 
#
# -h, --help::   show help
#
# -t, --title::  set title
#
# -a, --author:: set author
#
# -d, --date::   set date. today by default.
#
# -u, --upload-only::   don't encode, just upload.
#
# -p, --post-only::     don't encode or upload, just make the post.
#
# tcf-encode creates a file in your current directory with the convention name of YYYY-MM-DD ~ title.mp3 
#
require 'getoptlong'
require 'rdoc/usage'
require 'date'
require 'net/ftp'
require 'xmlrpc/client'
require 'lib/tcf'
require 'lib/blog_client'

opts = GetoptLong.new(
  [ '--help',   '-h', GetoptLong::NO_ARGUMENT ],
  [ '--title',  '-t', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--author', '-a', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--date',   '-d', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--upload-only' , '-u', GetoptLong::NO_ARGUMENT ],
  [ '--post-only',    '-p', GetoptLong::NO_ARGUMENT ]
)

title = ''
author = ''
date = Date.today
post_only = upload_only = false
opts.each do |opt, arg|
  case opt
	when '--help'
	  RDoc::usage
	when '--title'
    title = arg
	when '--author'
    author = arg
  when '--date'
    date = Date.parse(arg)
  when '--upload-only'
    upload_only = true
  when '--post-only'
    post_only = true
  end
end

if ARGV.length != 1 && ! upload_only 
  puts "Missing file name argument (try --help)"
  exit 0
end

infile = ARGV.shift

tcf = TCF.new(date, title, author, infile)

tcf.compress unless upload_only || post_only
tcf.upload unless post_only
tcf.post unless upload_only
