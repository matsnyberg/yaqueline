require 'helper'
require 'yaqueline/configuration'

class TestConfiguration < Test::Unit::TestCase

  should "be able to read default configuation" do
    configuration = Yaqueline::Configuration.new
    assert configuration.config_file == '_config.yml', 'could not read the default configuration file'
  end

end
