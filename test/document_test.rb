require 'helper'
require 'yaqueline/document'

class DocumentTest < Test::Unit::TestCase
  context "documents" do
    setup do
      @document = Yaqueline::Document.new
    end
    should "be created (phony test)" do
      assert @document, 'document is not created'
    end
    should "be able to populate" do
      path = 'path/to/file'
      @document.path = path
      assert @document.to_s[path], 'path was not found'
    end
  end
end
