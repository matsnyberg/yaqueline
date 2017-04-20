require 'helper'
require 'yaqueline/build/sassbuilder'

class SassBuilderTest < Test::Unit::TestCase

  should "be able to read default configuation" do
    scss = '$bg: #0000ff; #main {background-color: $bg}'
    css = Yaqueline::Build::SassBuilder.new.render scss
    assert css.include?('background-color: #0000ff'), 'css should include background-color'
  end

end
