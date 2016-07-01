module PPTXMarkdown
  Presentation = Struct.new(:slides) do
    def initialize(*)
      super
      self.slides ||= []
    end

    def to_markdown
      slides.map(&:to_markdown).join
    end

    # @return [String] XML for ppt/presentation.xml
    def to_xml
      Nokogiri::XML::Builder.new do |xml|
        xml['p'].presentation(XML_NAMESPACES) do
          xml.sldMasterIdLst do
            xml.sldMasterId(id: 2_147_483_648, 'r:id' => 'rId1')
          end
          xml.sldIdLst do
            slides.each_with_index do |_, index|
              xml.sldId(
                id: 255 + (index + 1),
                'r:id' => "rId#{(index + 1) + 5}"
              )
            end
          end
          xml.sldSz(cx: 9_144_000, cy: 6_858_000, type: 'screen4x3')
          xml.notesSz(cx: 6_858_000, cy: 9_144_000)
        end
      end.to_xml
    end

    # @return [String] XML for ppt/_rels/presentation.xml.rels
    def to_xml_rels
      Nokogiri::XML::Builder.new do |xml|
        xml.Relationships(xmlns: 'http://schemas.openxmlformats.org/package/2006/relationships') do
          xml.Relationship(
            'Id' => 'rId1',
            'Type' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme',
            'Target' => 'theme/theme1.xml'
          )
          xml.Relationship(
            'Id' => 'rId2',
            'Type' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps',
            'Target' => 'presProps.xml'
          )
          xml.Relationship(
            'Id' => 'rId3',
            'Type' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster',
            'Target' => 'slideMasters/slideMaster1.xml'
          )
          xml.Relationship(
            'Id' => 'rId4',
            'Type' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesMaster',
            'Target' => 'notesMasters/notesMaster1.xml'
          )
          slides.each_with_index do |_, index|
            xml.Relationship(
              'Id' => "rId#{5 + index + 1}",
              'Type' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide',
              'Target' => "slides/slide#{index + 1}.xml"
            )
          end
        end
      end.to_xml
    end
  end
end
