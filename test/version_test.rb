require 'helper'
require 'yaqueline/version'

class TestVersion < Test::Unit::TestCase
  should "return a version" do
    assert Yaqueline::VERSION, "couldn't get the version"
  end
end
