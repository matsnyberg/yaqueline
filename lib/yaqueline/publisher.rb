require 'fileutils'
require 'yaqueline/configuration'
module Yaqueline::Publisher

  def publish_page filename, content
    FileUtils.mkdir_p File.dirname(filename)
    IO.write(filename, content)
  end

  def publish_post filename, content
    FileUtils.mkdir_p File.dirname(filename)
    IO.write(filename, content)
  end

  def new_filename path
    File.join(Yaqueline::Configuration.absolute_path(:dest), path)
      .to_s.sub('_posts/', '')
      .sub(/(\d{4})\W(\d{2})\W(\d{2})\W/, '\1/\2/\3/')
      .sub(/\.\w+$/, '.html')        
  end

end
