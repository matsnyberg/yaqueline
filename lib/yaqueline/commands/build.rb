# encoding: UTF-8
require "yaqueline/command"
require 'yaqueline/templatemanager'
require 'yaqueline/filemanager'
require 'yaqueline/build/compiler'

module Yaqueline
  module Commands
    class Build < Command


      class << self


        def init_with_program prog, configuration
          puts 'initing build'
          prog.command(:build) do |c|
            c.syntax "build"
            c.description "Builds a new Yaqueline site from SOURCE in DESTINATION (default is ./_site)"

            c.action do |args, options|
              process args, options, configuration
            end
          end
        end

        def process args, options, configuration
          begin
            puts "building site..."
            filemanager = prepare args, options
            compile filemanager, configuration
          rescue => error
            puts "Error: " + error.message
            puts error.backtrace
          end
        end

        def prepare args, options
          Yaqueline::FileManager.new Dir.pwd, configuration
        end

        def compile args, options
          compiler = Yaqueline::Build::Compiler.new filemanager, configuration
          compiler.compile
        end


      end


    end
  end
end
