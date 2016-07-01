module PPTXMarkdown
  module Parsers
    Markdown = Struct.new(:path) do
      def call
        presentation = PPTXMarkdown::Presentation.new

        content.each_line do |line|
          if !line.start_with?("\t")
            presentation.slides.push(
              PPTXMarkdown::Slide.new([
                PPTXMarkdown::Shape.new(parse_content(line), 'title')
              ])
            )

            next
          end

          presentation.slides.last.shapes.push(
            PPTXMarkdown::Shape.new(parse_content(line), 'body')
          )
        end

        presentation
      end

      private

        def parse_content(line)
          line.scan(/[\t]*\*\s(.+)/)&.first&.first
        end

        def content
          File.open(path).read
        end
    end
  end
end
