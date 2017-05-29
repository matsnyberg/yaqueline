require 'spec_helper'
require 'yaqueline/publisher'

describe Yaqueline::Publisher do
  include Yaqueline::Publisher
  context 'new_filename' do
    config_file = File.join(File.dirname(__FILE__), '..', 'fixtures', 'config-configuration_test.yml')
    Yaqueline::Configuration.init [], config: config_file, source: '/var'
    it 'should replace a file extension with .html' do
      expect(new_filename('abc.xyz')).to be == '/var/_site/abc.html'
    end
    it 'should replace a date in the title with a path' do
      puts new_filename('2013-08-03-abc.xyz')
      expect(new_filename('2013-08-03-abc.xyz')).to be == '/var/_site/2013/08/03/abc.html'
    end
  end
end
