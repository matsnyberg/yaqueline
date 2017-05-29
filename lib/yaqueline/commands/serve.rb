# encoding: UTF-8
require "yaqueline/command"
require 'yaqueline/watcher'

require 'webrick'
class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler
  def prevent_caching(res)
    res['ETag']          = nil
    res['Last-Modified'] = Time.now + 100**4
    res['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
    res['Pragma']        = 'no-cache'
    res['Expires']       = Time.now - 100**4
  end
  
  def do_GET(req, res)
    super
    prevent_caching(res)
  end

end

module Yaqueline
  module Commands
    class Serve < Command
      class << self

        def init_with_program prog
          prog.command(:serve) do |c|
            c.syntax "serve"
            c.description "Start a webserver serving the newly built site (default is ./_site)"
            c.action do |args, options|
              execute(args, options) do
                Watcher.start(false)
                server = WEBrick::HTTPServer.new :Port => 8000
                server.mount "/", NonCachingFileHandler , File.join(Dir.pwd, '_site')
                trap('INT') { server.stop }
                server.start
              end
            end
          end
        end

      end # class << self
    end # class
  end
end
