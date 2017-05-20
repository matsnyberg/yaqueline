# encoding: UTF-8
require "yaqueline/command"
require 'yaqueline/builder'

module Yaqueline
  module Commands
    class Build < Command
      class << self

        def init_with_program prog
          prog.command(:build) do |c|
            c.syntax "build"
            c.description "Builds a new Yaqueline site from SOURCE in DESTINATION (default is ./_site)"
            c.action do |args, options|
              execute(args, options) do 
                Yaqueline::Builder.build_all
              end
            end
          end
        end

      end # class << self
    end # class
  end
end
