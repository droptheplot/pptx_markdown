module PPTXMarkdown
  module Parsers
    PPTX = Struct.new(:path) do
      CONTENT_PATH = 'p:txBody/a:p/a:r/a:t'.freeze
      TYPE_PATH = 'p:nvSpPr/p:nvPr/p:ph'.freeze

      def document
        @document ||= Zip::File.open(path)
      end

      def call
        PPTXMarkdown::Presentation.new(slides)
      end

      private

        def slides
          document.select { |f| f.name =~ %r{^ppt/slides/.+.xml$} }
                  .map do |f|
                    PPTXMarkdown::Slide.new(
                      fetch_shapes(document.file.open(f.name))
                    )
                  end
        end

        def fetch_shapes(slide)
          xml = Nokogiri::XML::Document.parse(slide)

          xml.xpath('//p:sp').map do |shape|
            begin
              PPTXMarkdown::Shape.new(
                fetch_content(shape),
                fetch_type(shape)
              )
            rescue PPTXMarkdown::TypeError
              next
            end
          end.compact
        end

        def fetch_content(shape)
          shape.xpath(CONTENT_PATH).text
        end

        def fetch_type(shape)
          return if shape.xpath(TYPE_PATH)[0].nil?

          shape.xpath(TYPE_PATH)[0]['type']
        end
    end
  end
end
