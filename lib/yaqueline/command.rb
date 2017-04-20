# encoding: utf-8
require 'mercenary'

module Yaqueline

  ##
  # Superclass of all Yaqueline commands
  class Command
    
    @@commands = Array.new

    class << self

      def inherited(subclass)
        @@commands << subclass
      end

      def commands
        @@commands
      end

      def execute configuration
        begin
          Mercenary.program(:yaqueline) do |p|
            p.version Yaqueline::VERSION
            p.description "Yaqueline, like Jekyll, is a blog-aware, static site generator in Ruby"
            p.syntax "yaqueline <subcommand> [options]"

            p.option "source", "-s", "--source [DIR]", "Source directory (defaults to ./)"
            p.option "destination", "-d", "--destination [DIR]", "Destination directory (defaults to ./_site)"
            p.option "plugins_dir", "-p", "--plugins PLUGINS_DIR1[,PLUGINS_DIR2[,...]]", Array, "Plugins directory (defaults to ./_plugins)"
            p.option "layouts_dir", "--layouts DIR", String, "Layouts directory (defaults to ./_layouts)"

            commands.each do |c|
              c.init_with_program p, configuration
            end
            p.default_command(:build)
          end
        rescue => error
          puts "Error: " + error.message
          puts error.backtrace
        end
      end
    end

    def process args, options
      raise StandardError.new %q{You must override proces in Command subclasses.}
    end

    def prepare args, options

    end

    def compile args, options

    end
  end

end
