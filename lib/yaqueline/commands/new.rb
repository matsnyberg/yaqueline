# encoding: UTF-8
require 'yaqueline/command'
require 'fileutils'

module Yaqueline
  module Commands
    class New < Command

      TEMPLATE_PATH = File.absolute_path(File.join(File.dirname(__FILE__), %q{../../../etc/site_template}))

      TOO_MANY_ARGS = %q{Command new takes exactly one arg.}
      DIR_EXISTS = %q{Directory exists will not create without --force}

      class << self

        def init_with_program prog, configuration
          prog.command(:new) do |c|
            c.syntax 'new NAME'
            c.description %q{Creates a new Jekyll site scaffold in PATH}
            c.option 'force', '--force', 'Force creation even if PATH already exists'
            c.action do |args, options|
              process args, options, configuration
            end
          end
        end

        def process args, options, configuration = nil
          raise ArgumentError.new TOO_MANY_ARGS if args.length != 1
          raise IOError.new DIR_EXISTS if (File.exist?(site_root args) && !(force? options))
          puts "initializing a new site in #{site_root args}."
          copy_site site_root args
        end

        protected

        def site_root args
          File.join(Dir.pwd, args[0])
        end

        def force? options
          options.key?('force')
        end

        def copy_site site_root
          FileUtils::mkdir_p site_root if !File.exist?(site_root)
          Dir.glob(File.join(TEMPLATE_PATH, '**/*')).each do |f|
            unless File.absolute_path(f).nil?
              new_dir = File.absolute_path(f)
              new_dir = File.join(site_root, new_dir[(TEMPLATE_PATH.length + 1)..new_dir.length])
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
