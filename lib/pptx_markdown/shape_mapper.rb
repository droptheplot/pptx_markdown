require 'ostruct'

module PPTXMarkdown
  class ShapeMapper
    # 1pt to English Metric Units
    EMU = 12_700

    # Space between shapes
    MARGIN = 25

    # Shape height
    Y_SIZE = 30

    # Shape width
    X_SIZE = 670

    def next
      factor = collection.next

      OpenStruct.new(
        {
          x: MARGIN,
          y: (MARGIN + Y_SIZE) * factor + MARGIN,
          cx: X_SIZE,
          cy: (MARGIN * 2) + (Y_SIZE * 2)
        }.map { |k, v| [k, v * EMU] }.to_h
      )
    end

    private

      def collection
        @collection ||= (1..Float::INFINITY).to_enum
      end
  end
end
