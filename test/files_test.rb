# encoding: UTF-8
require 'helper'
require 'yaqueline/document'
require 'yaqueline/document_parser'
require 'yaqueline/configuration'
require 'yaqueline/files'

class FilesTest < Test::Unit::TestCase
  context "files" do
    setup do
      Yaqueline::Configuration.init [], source: 'test/fixtures/blog'
    end
    should "be able to collect files in a Yaqueline repo correctly" do
      Yaqueline::Files.collect_files
    end
  end
end
