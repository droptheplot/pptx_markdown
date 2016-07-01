require 'nokogiri'
require 'zip/filesystem'

require_relative 'pptx_markdown/builders/markdown'
require_relative 'pptx_markdown/builders/pptx'
require_relative 'pptx_markdown/parsers/pptx'
require_relative 'pptx_markdown/parsers/markdown'
require_relative 'pptx_markdown/presentation'
require_relative 'pptx_markdown/slide'
require_relative 'pptx_markdown/shape'
require_relative 'pptx_markdown/shape_mapper'

module PPTXMarkdown
  XML_NAMESPACES = {
    'xmlns:a' => 'http://schemas.openxmlformats.org/drawingml/2006/main',
    'xmlns:r' => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    'xmlns:mc' => 'http://schemas.openxmlformats.org/markup-compatibility/2006',
    'xmlns:mv' => 'urn:schemas-microsoft-com:mac:vml',
    'xmlns:p' => 'http://schemas.openxmlformats.org/presentationml/2006/main',
    'xmlns:c' => 'http://schemas.openxmlformats.org/drawingml/2006/chart',
    'xmlns:dgm' => 'http://schemas.openxmlformats.org/drawingml/2006/diagram',
    'xmlns:o' => 'urn:schemas-microsoft-com:office:office',
    'xmlns:v' => 'urn:schemas-microsoft-com:vml',
    'xmlns:pvml' => 'urn:schemas-microsoft-com:office:powerpoint',
    'xmlns:com' => 'http://schemas.openxmlformats.org/drawingml/2006/compatibility',
    'xmlns:p14' => 'http://schemas.microsoft.com/office/powerpoint/2010/main'
  }.freeze
end
