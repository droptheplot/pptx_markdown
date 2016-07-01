require 'tmpdir'

module PPTXMarkdown
  module Builders
    PPTX = Struct.new(:presentation, :output_path) do
      def call
        Dir.mktmpdir do |tmp_path|
          FileUtils.copy_entry template_path, tmp_path

          generate_slides(tmp_path)
          generate_presentation(tmp_path)
          generate_presentation_rels(tmp_path)

          create_pptx(tmp_path)
        end
      end

      private

        def create_pptx(dir)
          Zip::File.open(output_path, Zip::File::CREATE) do |pptx_file|
            Dir.glob("#{dir}/**/*", ::File::FNM_DOTMATCH).each do |path|
              pptx_path = path.gsub("#{dir}/", '')

              next if pptx_path == '.' || pptx_path == '..'

              begin
                pptx_file.add(pptx_path, path)
              rescue Zip::EntryExistsError
                puts 'File already exists.'
                break
              end
            end
          end
        end

        def generate_slides(tmp_path)
          presentation.slides.each_with_index do |slide, index|
            File.open(slide_path(tmp_path, index), 'w') do |f|
              f.write(slide.to_xml(index))
            end
          end
        end

        def generate_presentation(tmp_path)
          File.open(File.join(tmp_path, 'ppt/presentation.xml'), 'w') do |f|
            f.write(presentation.to_xml)
          end
        end

        def generate_presentation_rels(tmp_path)
          File.open(File.join(tmp_path, 'ppt/_rels/presentation.xml.rels'), 'w') do |f|
            f.write(presentation.to_xml_rels)
          end
        end

        def slide_path(tmp_path, index)
          File.join(tmp_path, 'ppt/slides', "slide#{index + 1}.xml")
        end

        def template_path
          File.join(File.expand_path(File.dirname(__FILE__)), '../template')
        end
    end
  end
end
