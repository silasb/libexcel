require 'libxml'
require 'libexcel/document'
require 'libexcel/worksheet'
require 'libexcel/formula'

module LibExcel

  class << self

    # Creates the full Excel XML equation string
    #
    # @return [String] the full Excel style equation string
    def range(args)
      if args[:cols].nil?
        (buf = static(args[:rows].first, args[:col])) << ':'
        buf << static(args[:rows].last, args[:col])
      elsif args[:rows].nil?
        (buf = static(args[:row], args[:cols].first)) << ':'
        buf << static(args[:row], args[:cols].last)
      else
        (buf = static(args[:rows].first, args[:cols].first)) << ':'
        buf << static(args[:rows].last, args[:cols].last)
      end
    end

    # Creates part of the Excel XML style equation string
    #
    # @example
    #   static(1, 1)   => "R[1]C[1]"
    #   static(0, 1)   => "R[0]C[1]"
    #   static(1)      => "R[1]C"
    #   static(nil, 1) => "RC[1]"
    # 
    # @param [Integer, Integer] the two integer values to be converted
    # @return [String] the Excel style equation string
    def static(row, col)
      if col.nil?
        "R[#{row}]C"
      elsif row.nil?
        "RC[#{col}]"
      else
        "R[#{row}]C[#{col}]"
      end
    end

  end

end
