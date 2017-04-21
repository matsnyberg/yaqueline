require 'helper'
require 'yaqueline/filemanager'
require 'ostruct'

class TestFileManager < Test::Unit::TestCase

  CONFIGURATION = OpenStruct.new({
      :config_file => '_config.yml',
      :layouts_dir => '_layouts',
      :includes_dir => '_includes',
      :scss_dir => '_scss',
      :css_dir => 'css'
  })

  SITE = File.join(File.dirname(__FILE__), 'blog')

  should 'be able to render a chain of templates' do
    filemanager = Yaqueline::FileManager.new SITE, CONFIGURATION
    assert !(filemanager.template('default').nil?), 'default.html should be available'
  end

end
