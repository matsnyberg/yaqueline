# encoding: UTF-8
require 'asciidoctor'
require 'asciidoctor/converter'
require 'asciidoctor/converter/html5'

module Yaqueline
  module Converters
    
    class YaquelineHtml5Converter < Asciidoctor::Converter::Html5Converter
      extend Asciidoctor::Converter::Config

      register_for 'yaqueline_html5'
      
      def stem(node)
        return super unless node.style.to_sym == :latexmath
        
        %(<pre#{id_attribute(node)} class="code math js-render-math #{node.role}" data-math-style="display"><code>#{node.content}</code></pre>)
      end
      
      def paragraph node
        class_attribute = node.role ? %(class="paragraph #{node.role}") : 'class="paragraph mats"'
        attributes = node.id ? %(id="#{node.id}" #{class_attribute}) : class_attribute

        if node.title?
          %(<div #{attributes}>
<div class="title">#{node.title}</div>
<p>#{node.content}</p>
</div>)
        else
          %(<p>#{node.content}</p>)
        end
      end

      def inline_quoted(node)
        return super unless node.type.to_sym == :latexmath
        
        %(<code#{id_attribute(node)} class="code math js-render-math #{node.role}" data-math-style="inline">#{node.text}</code>)
      end
      
      private
      
      def id_attribute(node)
        node.id ? %( id="#{node.id}") : nil
      end
      
    end # class
  end
end
