# encoding: UTF-8
require 'helper'
require 'yaqueline/document'
require 'yaqueline/document_parser'
require 'yaqueline/configuration'

class DocumentParserTest < Test::Unit::TestCase
  context "document_parser.relativize_path" do
    setup do
      Yaqueline::Configuration.init [], config: 'test/fixtures/config-configuration_test.yml'
    end
    should "be able to relativize paths correctly" do
      path = 'test/fixtures'
      assert_equal path, Yaqueline::DocumentParser.relativize_path(File.absolute_path path), 'Path should be relativized correctly'
    end
  end
  context "document_parser.parse" do
    setup do
      Yaqueline::Configuration.init [], config: 'test/fixtures/config-configuration_test.yml'
    end
    
    should "be able to parse documents" do
      path = File.absolute_path 'test/fixtures/documents/document1.html'
      document = Yaqueline::DocumentParser.parse path
    end
  end
end
