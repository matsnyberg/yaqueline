# encoding: UTF-8
require 'yaqueline/command'
require 'fileutils'

module Yaqueline
  module Commands
    class New < Command

      TEMPLATE_PATH = File.absolute_path(File.join(File.dirname(__FILE__), '..', '..', 'template'))

      TOO_MANY_ARGS = %q{Command new takes exactly one arg.}
      DIR_EXISTS = %q{Directory exists will not create without --force}

      class << self

        def init_with_program prog
          prog.command(:new) do |c|
            c.syntax 'new NAME'
            c.description %q{Creates a new Yaqueline site scaffold in NAME}
            c.option 'force', '--force', 'Force creation even if PATH already exists'
            c.action do |args, options|
              execute(args, options) do
                process
              end
            end
          end
        end

        def process
          raise ArgumentError.new TOO_MANY_ARGS if Yaqueline::Configuration.args.length != 1
          source = Yaqueline::Configuration.args[0]
          raise IOError.new DIR_EXISTS if File.exist? source
          puts "initializing a new site in #{source}."
          copy_site source
        end

        def force? options
          options.key?('force')
        end

        def copy_site source
          FileUtils::mkdir_p source if !File.exist?(source)
          Dir.glob(File.join(TEMPLATE_PATH, '**/*')).each do |f|
            unless File.absolute_path(f).nil?
              new_dir = File.absolute_path(f)
              new_dir = File.join(source, new_dir[(TEMPLATE_PATH.length + 1)..new_dir.length])
              make_dir(new_dir) if File.directory?(f)
              copy_file(f, new_dir) if !File.directory?(f)
            end
          end
        end

        def make_dir dir
          puts "mkdir #{dir} "
          FileUtils::mkdir_p dir if !File.exist?(dir)
        end

        def copy_file source, dest
          puts "cp #{source} -> #{dest} "
          FileUtils.cp(source, dest)
        end
        
      end
    end
  end
end
