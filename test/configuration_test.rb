require 'helper'
require 'yaqueline/configuration'

class TestConfiguration < Test::Unit::TestCase
  context "a configurstio" do
    setup do
      Yaqueline::Configuration.init [], config: 'test/fixtures/config-configuration_test.yml', source: 'XXX'
    end
    
    should "return 'XXX' for :souce from CLI options" do
      assert_equal 'XXX', Yaqueline::Configuration.get(:source)
    end
    
    should "return 'YYY' for :layouts from config file" do
      assert_equal 'YYY', Yaqueline::Configuration.get(:layouts)
    end
    
    should "return '_includes' for :includes from DEFAULTS" do
      assert_equal '_includes', Yaqueline::Configuration.get(:includes)
    end
  end
end
