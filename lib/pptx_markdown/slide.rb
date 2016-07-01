module PPTXMarkdown
  Slide = Struct.new(:shapes) do
    def to_markdown
      shapes.map(&:to_markdown).join
    end

    # @return [String] XML ppt/slides/slide0.xml with nested shapes
    def to_xml(index)
      node_collection = PPTXMarkdown::ShapeMapper.new

      Nokogiri::XML::Builder.new do |xml|
        xml['p'].sld(XML_NAMESPACES) do
          xml.cSld do
            xml.spTree do
              xml.nvGrpSpPr do
                xml.cNvPr(id: 255 + index + 1, name: nil)
                xml.cNvGrpSpPr
                xml.nvPr
              end
              xml.grpSpPr do
                xml['a'].xfrm do
                  xml.off(x: 0, y: 0)
                  xml.ext(cx: 0, cy: 0)
                  xml.chOff(x: 0, y: 0)
                  xml.chExt(cx: 0, cy: 0)
                end
              end
              shapes.each do |shape|
                xml << shape.to_xml(node_collection.next)
              end
            end
          end
          xml.clrMapOvr do
            xml['a'].masterClrMapping
          end
        end
      end.to_xml
    end
  end
end
