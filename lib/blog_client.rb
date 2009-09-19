require 'xmlrpc/client'
require 'uri'

# http://www.devdaily.com/scw/ruby/blogclient-0.0.20041025/lib/blog/client.rb.shtml

module Blog
  class Client
    class BlogClientFault < StandardError
    end
    class Content
      def initialize(attrs={})
        @userid = nil
        @postid = nil
        @title = nil
        @link  = nil
        @permaLink = nil
        @description = nil
        @dateCreated = nil
        @mt_allow_comments = nil
        @mt_allow_pings = nil
        @mt_convert_breaks = nil
        @mt_text_more = nil
        @mt_excerpt = nil
        @mt_keywords = nil
        @mt_tb_ping_urls = nil
        attrs.each do |k,v|
          send(:"#{k}=",v)
        end
      end
      attr_accessor :userid, :postid, :link, :permaLink
      attr_accessor :title, :description, :dateCreated
      attr_accessor :mt_allow_comments, :mt_allow_pings, :mt_convert_breaks, :mt_text_more, :mt_excerpt, :mt_keywords, :mt_tb_ping_urls

      def to_struct
        h = {}
        h['title'] = @title
        h['description'] = @description
        h['dateCreated'] = @dateCreated
        h['mt_allow_comments'] = @mt_allow_comments unless @mt_allow_comments.nil?
        h['mt_allow_pings'] = @mt_allow_pings unless @mt_allow_pings.nil?
        h['mt_convert_breaks'] = @mt_convert_breaks unless @mt_convert_breaks.nil?
        h['mt_text_more'] = @mt_text_more unless @mt_text_more.nil?
        h['mt_excerpt'] = @mt_excerpt unless @mt_excerpt.nil?
        h['mt_keywords'] = @mt_keywords unless @mt_keywords.nil?
        h['mt_tb_ping_urls'] = @mt_tb_ping_urls unless @mt_tb_ping_urls.nil?
        h
      end
    end # Content

    def initialize(server, appkey, username, password)
      @appkey = appkey
      @username = username
      @password = password
      server_uri = URI.parse(server)
      path = server_uri.path
      path << "?" << server_uri.query if server_uri.query
      @client = XMLRPC::Client.new(server_uri.host, path, server_uri.port)
    end

    def blogger_newPost(blogid, content, publish=true)
      result = @client.call('blogger.newPost', @appkey, blogid, @username, @password, content, publish)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def blogger_editPost(postid, content, publish=true)
      result = @client.call('blogger.editPost', @appkey, postid, @username, @password, content, publish)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def blogger_deletePost(postid, publish=true)
      result = @client.call('blogger.deletePost', @appkey, postid, @username, @password, publish)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def blogger_getRecentPosts(blogid, numberOfPosts=1)
      result = @client.call('blogger.getRecentPosts', @appkey, blogid, @username, @password, numberOfPosts)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def blogger_getUsersBlogs
      result = @client.call('blogger.getUsersBlogs', @appkey, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def blogger_getUserInfo
      result = @client.call('blogger.getUserInfo', @appkey, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def metaWeblog_newPost(blogid, content, publish=true)
      content = content.to_struct if Content===content
      result = @client.call('metaWeblog.newPost', blogid, @username, @password, content, publish)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def metaWeblog_editPost(postid, content, publish=true)
      content = content.to_struct if Content===content
      result = @client.call('metaWeblog.editPost', postid, @username, @password, content, publish)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def metaWeblog_getPost(postid)
      result = @client.call('metaWeblog.getPost', postid, @username, @password)
      content = Content.new
      content.userid            = result['userid']
      content.dateCreated       = result['dateCreated']
      content.postid            = result['postid']
      content.description       = result['description']
      content.title             = result['title']
      content.link              = result['link']
      content.permaLink         = result['permaLink']
      content.mt_excerpt        = result['mt_excerpt']
      content.mt_text_more      = result['mt_text_more']
      content.mt_allow_comments = result['mt_allow_comments']
      content.mt_allow_pings    = result['mt_allow_pings']
      content.mt_convert_breaks = result['mt_convert_breaks']
      content.mt_keywords       = result['mt_keywords']
      content
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def metaWeblog_getRecentPosts(blogid, numberOfPosts=1)
      result = @client.call('metaWeblog.getRecentPosts', blogid, @username, @password, numberOfPosts)
      ary = []
      result.each {|r|
        content = Content.new
        content.userid            = r['userid']
        content.dateCreated       = r['dateCreated']
        content.postid            = r['postid']
        content.description       = r['description']
        content.title             = r['title']
        content.link              = r['link']
        content.permaLink         = r['permaLink']
        content.mt_excerpt        = r['mt_excerpt']
        content.mt_text_more      = r['mt_text_more']
        content.mt_allow_comments = r['mt_allow_comments']
        content.mt_allow_pings    = r['mt_allow_pings']
        content.mt_convert_breaks = r['mt_convert_breaks']
        content.mt_keywords       = r['mt_keywords']
        ary << content
      }
      ary
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def metaWeblog_newMediaObject(blogid, name, object)
      file = {
        'name' => name,
        'bits' => XMLRPC::Base64.new(object.to_s)
      }
      result = @client.call('metaWeblog.newMediaObject', blogid, @username, @password, file)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_getRecentPostTitles(blogid, numberOfPosts=1)
      result = @client.call('mt.getRecentPostTitles', blogid, @username, @password, numberOfPosts)
      ary = []
      result.each {|r|
        content = Content.new
        content.dateCreated       = r['dateCreated']
        content.userid            = r['userid']
        content.postid            = r['postid']
        content.title             = r['title']
        ary << content
      }
      ary
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_getCategoryList(blogid)
      result = @client.call('mt.getCategoryList', blogid, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end
    
    def mt_getPostCategories(postid)
      postid = postid.postid if Content===postid
      result = @client.call('mt.getPostCategories', postid, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_setPostCategories(postid, categories)
      postid = postid.postid if Content===postid
      result = @client.call('mt.setPostCategories', postid, @username, @password, categories)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_supportedMethods
      result = @client.call('mt.supportedMethods')
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_supportedTextFilters
      result = @client.call('mt.supportedTextFilters')
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_getTrackbackPings(postid)
      postid = postid.postid if Content===postid
      result = @client.call('mt.getTrackbackPings', postid)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end

    def mt_publishPost
      result = @client.call('mt.publishPost', postid, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end
    
    def mt_setNextScheduledPost(postid, dateCreated=nil)
      if Content===postid
        dateCreated ||= postid.dateCreated
        postid        = postid.postid
      end
      result = @client.call('mt.setNextScheduledPost', postid, dateCreated, @username, @password)
    rescue XMLRPC::FaultException
      raise BlogClientFault.new($!.faultString)
    end
  end # Client
end # Blog

