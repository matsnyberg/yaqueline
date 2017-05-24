require 'spec_helper'
require 'yaqueline/configuration'

describe Yaqueline::Configuration do
  context 'a Configuration with config file and command line options' do
    config_file = File.join(File.dirname(__FILE__), '..', 'fixtures', 'config-configuration_test.yml')
    Yaqueline::Configuration.init [], config: config_file, source: '/var'
    it '#get should return /var for source (from command-line arguments)' do
      expect(Yaqueline::Configuration.get(:source)).to be == '/var'
    end
    it '#get should return templates for layouts (from configuration file)' do
      expect(Yaqueline::Configuration.get(:layouts)).to be == 'templates'
    end
    it '#get should return _includes for :includes (from DEFAULT values)' do
      expect(Yaqueline::Configuration.get(:includes)).to end_with '_includes'
    end
    it '#absolute_path should return /var/templates for layouts (from configuration file)' do
      expect(Yaqueline::Configuration.absolute_path(:layouts)).to be == '/var/templates'
    end
    it '#absolute_path should return /var/_includes for :includes (from DEFAULT values)' do
      expect(Yaqueline::Configuration.absolute_path(:includes)).to be == '/var/_includes'
    end
  end
end
