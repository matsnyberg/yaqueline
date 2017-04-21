require 'helper'
require 'yaqueline/document'

class TestDocument < Test::Unit::TestCase

  should "be able to get a one-word key from file path" do
    document = Yaqueline::Document.new File.join(File.dirname(__FILE__), 'annotatedfile1.html')
    key = document.path2key 'some/path/to/file.html'
    assert 'file' == key, 'key should be "file"'
  end

  should "split content successfully" do
    document = Yaqueline::Document.new File.join(File.dirname(__FILE__), 'annotatedfile1.html')
    assert document.title, 'there should be a title'
    assert document.body, 'file should have content'
  end

  should "work w/o front matter" do
    document = Yaqueline::Document.new File.join(File.dirname(__FILE__), 'annotatedfile2.html')
    assert !document.title, 'title should be abscent'
    assert document.body, 'file should have content'
  end

end
