require 'helper'
require 'yaqueline/template'

class TestTemplate < Test::Unit::TestCase

  TEMPLATE = File.join(File.dirname(__FILE__), 'template1.html')
  
  should "be able to load templates" do
    template = Yaqueline::Template.new TEMPLATE
    template.author = %q{Mats Nyberg}
    content = template.render
    assert content =~ /Mats Nyberg/, 'result should contain author name'
  end

  should "handle abscent attributes" do
    template = Yaqueline::Template.new TEMPLATE
    content = template.render
    flunk 'result should not contain author name' if content =~ /Mats Nyberg/ # silly
  end

  should 'be able to render multiple times with same result' do
    results = []
    template = Yaqueline::Template.new TEMPLATE
    [0..3].each do
      template.author = %q{Mats Nyberg}
      results << template.render
    end
    results.each do |r1|
      results.each do |r2|
        assert_equal r1, r2, 'results should be equal'
      end
    end
  end

end
