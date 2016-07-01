module PPTXMarkdown
  class TypeError < StandardError
  end

  Shape = Struct.new(:content, :type) do
    TITLE_IDS = %w(ctrTitle title).freeze
    BODY_IDS = %w(subTitle body).freeze

    def initialize(*)
      super

      raise PPTXMarkdown::TypeError unless (TITLE_IDS + BODY_IDS).include?(type)
    end

    # @return [Boolean]
    def title?
      TITLE_IDS.include?(type)
    end

    # @return [Boolean]
    def body?
      BODY_IDS.include?(type)
    end

    def to_markdown
      tag = title? ? '* ' : "\t* "
      format("%s%s\n", tag, content)
    end

    # @return [String] XML for text shape for ppt/slides/slide0.xml
    def to_xml(node)
      Nokogiri::XML::Builder.new do |xml|
        xml.sp(XML_NAMESPACES) do
          xml.nvSpPr do
            xml.cNvPr(id: '', name: '')
            xml.cNvSpPr(txBox: 1)
            xml.nvPr do
              xml.ph(idx: nil, type: type)
            end
          end
          xml.spPr do
            xml['a'].xfrm do
              xml.off(x: node.x, y: node.y)
              xml.ext(cx: node.cx, cy: node.cy)
            end
            xml['a'].prstGeom(prst: 'rect') do
              xml.avLst
            end
          end

          xml.txBody do
            xml['a'].bodyPr(anchorCtr: 0, anchor: 't', bIns: 0, lIns: 0, rIns: 0, tIns: 0) do
              xml.noAutofit
            end
            xml['a'].lstStyle
            xml['a'].p do
              xml.pPr(lvl: 0) do
                xml.spcBef do
                  xml.spcPts(val: 0)
                end
                xml.buNone
              end
              xml.r do
                xml.t(content)
              end
            end
          end
        end
      end.doc.root.to_xml
    end
  end
end
