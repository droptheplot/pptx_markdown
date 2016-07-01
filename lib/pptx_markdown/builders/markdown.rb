module PPTXMarkdown
  module Builders
    Markdown = Struct.new(:presentation, :output_path) do
      def call
        File.open(output_path, 'w') { |f| f.write(presentation.to_markdown) }
      end
    end
  end
end
