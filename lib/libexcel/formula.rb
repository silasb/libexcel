module LibExcel
  # Manages a Formula object to be used in a {Excel::Worksheet}.  
  # Builds an Excel XML formula.  The Formula class responds to any 
  # +class method+.  Such methods should correspond to their Excel
  # counterparts.
  #
  # Some Excel formulas that will work are:
  # * COUNTA
  # * SUM
  # * etc.
  #
  # @example
  #   formula = Excel::Formula.counta(:row => 1..2)
  #   # Creates an equivalent formula =COUNTA(1:2)
  #   
  class Formula
    attr_reader :xml

    # <b>Should never be called directly.</b>
    # Creates the Formula object
    def initialize(equ)
      @xml = LibXML::XML::Node.new('Cell')
      @xml['ss:Formula'] = equ
    end

    # Creates a new Formula thats references the division of one Formula
    # by another Formula.
    #
    # @return [Formula] A new Formula reference
    #
    # @example
    #   f1 = Excel::Formula.counta(:row => 1..2)
    #   f2 = Excel::Formula.counta(:row => 1..2)
    #   f1_divided_f2 = f1/f1
    def /(formula)
      org_f = self.xml['ss:Formula']
      org_f << '/' << formula.xml['ss:Formula'][1..-1]
      Formula.new(org_f) 
    end

    def self.node_correct?(node)
      digit_block = /(\[-?\d+\])?/
      r_d_block = /R#{digit_block}C#{digit_block}/
      function = /=[A-Z]+\(#{r_d_block}:#{r_d_block}\)/

      (node['ss:Formula'] =~ function) != nil
    end

    def self.partition(node)
      digit_block = /(\[-?\d+\])?/
      big_block = /R#{digit_block}C#{digit_block}:R#{digit_block}C#{digit_block}/

      m = big_block.match(node['ss:Formula']).to_a[1..4]
      m.map { |bits| bits.nil? ? nil : bits[1..-2].to_i }
    end

    # A class method that is a catchall for equation names.
    def self.method_missing(meth, *args)
      buffer = "=#{meth.to_s.upcase}(#{LibExcel.range(args.first)})"

      self.new(buffer)
    end

    private
    # @deprecated This isn't used in production but still help here
    # for testings purposes.
    #
    # @see Excel.range for the actually production impl
    def self.build_formula(hash)
      if hash.is_a? Hash
        buffer = ""
        buffer << (hash.include?(:r) ? "R[#{hash[:r]}]" : "R")
        buffer << (hash.include?(:c) ? "C[#{hash[:c]}]" : "C")
        buffer << (hash.include?(:r2) ? ":R[#{hash[:r2]}]" : ":R")
        buffer << (hash.include?(:c2) ? "C[#{hash[:c2]}]" : "C")
      else
        buffer = "RC:RC"
      end
    end

  end
end
