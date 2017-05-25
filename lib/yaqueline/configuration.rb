require 'safe_yaml'
SafeYAML::OPTIONS[:default_mode] = :safe
module Yaqueline
  class Configuration

    # Maps keys of the _config.yml to internal symbol keys
    INTERNAL_KEYS = {
      "config_file"         => :config,
      "layouts_dir"         => :layouts,
      "includes_dir"        => :includes,
      "scss_dir"            => :scss,
      "css_dir"             => :css
    }

    # Default config values
    DEFAULTS = {
      :source               => Dir.pwd,
      :dest                 => '_site',
      :config               => '_config.yml',
      :layouts              => '_layouts',
      :includes             => '_includes',
      :plugins              => '_plugins',
      :scss                 => '_scss',
      :css                  => 'css'
    }

    class << self

      def init args, options={}
        @@args = args
        @@options = normalized options
        @@config = normalized config_file @@options
      end

      def config_file options
        file_name = options[:config] || DEFAULTS[:config]        
        result = Hash.new
        result.merge!(YAML.load_file(file_name)) if File.exist? file_name
        result
      end

      def normalized hash
        hash = hash.map do |k, v|
          if INTERNAL_KEYS.key? k
            [INTERNAL_KEYS[k], v]
          else
            [k, v]
          end
        end
        hash.to_h
      end
      
      def get(property)
        @@options[property] || @@config[property] || DEFAULTS[property]
      end

      def absolute_path(property)
        value = get(property)
        return nil unless value
        File.absolute_path(File.join(get(:source), value))
      end

      def args
        @@args
      end

    end # class << self
  end # class
end
