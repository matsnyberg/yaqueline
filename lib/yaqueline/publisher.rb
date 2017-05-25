require 'fileutils'
module Yaqueline::Publisher

  def publish_page filename, content
    FileUtils.mkdir_p File.dirname(filename)
    IO.write(filename, content)
  end

  def publish_post filename, content
    FileUtils.mkdir_p File.dirname(filename)
    IO.write(filename, content)
  end

end
