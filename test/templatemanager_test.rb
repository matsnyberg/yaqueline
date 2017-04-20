require 'helper'
require 'yaqueline/templatemanager'
require 'yaqueline/formatter'

class TestTemplateManager < Test::Unit::TestCase
  include Yaqueline::Formatter
  
  PAGE = File.join(File.dirname(__FILE__), 'page1.html')
  TEMPLATES = File.join(File.dirname(__FILE__), 'layouts')
  INCLUDES = File.join(File.dirname(__FILE__), 'includes')
  
  should 'be able to render a chain of templates' do
    Yaqueline::TemplateManager.prepare TEMPLATES, INCLUDES
    page = Yaqueline::Document.new PAGE
    content = page.render
    assert content =~ /default/, 'content should contain "default"'
    assert content =~ /page/, 'content should contain "page"'
    assert content =~ /pagecontent/, 'content should contain "pagecontent"'
    assert content =~ /partial1/, 'content should contain "partial1"'
  end

end
