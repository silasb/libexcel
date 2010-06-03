module LibExcel
  # Manages the worksheet of an {Excel::Document}
  #
  # A Worksheet works by first creating a row then by adding one cell
  # at a time until you call +add_row+ again to start on a new row.
  #
  # @example Create a Worksheet and add "hello world" to the first cell.
  #   worksheet = Excel::Worksheet.new('My worksheet')
  #   worksheet.add_row
  #   worksheet.add_cell("hello world")
  class Worksheet < LibXML::XML::Node
    include LibXML
    alias_method :append, :<<

    DEFAULT_COLUMN_WIDTH = '100'

    # Creates the Worksheet object. +name+ is the name of the Excel Document Tab. +name+ gets truncated to 31 chars.
    def initialize(name)
      super('Worksheet')
      # Excel complains if the name is more than 31 chars.
      self.name = name
      self.append table
      @f_column = XML::Node.new('Column')
      @f_column['ss:Width'] = DEFAULT_COLUMN_WIDTH
      @table << @f_column
    end

    def name
      self['ss:Name']
    end

    def f_column
      @f_column['ss:Width']
    end

    # Sets the +name+ and retuncates it to 31 chars.
    def name=(name)
      self['ss:Name'] = name.truncate
    end

    def f_column=(value)
      @f_column['ss:Width'] = value.to_s
    end

    # Creates a row in the Worksheet.  This needs to be called before
    # you can add data to the Worksheet.
    def add_row
      @table << @row = XML::Node.new('Row')
    end

    def add_cell(raw_data, attributes = {})
      @row << cell = XML::Node.new('Cell')
      if attributes[:formula]
        cell['ss:Formula'] = attributes[:formula]
      elsif not raw_data.nil?
        cell << data = XML::Node.new('Data')
        if raw_data.is_a?(Fixnum) or raw_data.is_a?(Float)
          data['ss:Type'] = 'Number'
        elsif raw_data.is_a? String
          data['ss:Type'] = 'String'
        end

        data << raw_data
      else
        cell << " "
      end
      data
    end

    # A helper method to add an array of data to the Worksheet.
    #
    # @param [Array] the Array of Objects being appended to the Worksheet.
    def add_array(array)
      for item in array
        self.add_cell(item)
      end
    end

    # Append anything that responds to +:xml+ to the Worksheet
    def <<(raw_data)
      if !raw_data.respond_to?(:xml)
        raise ArgumentError, "Need to have a Excel::Formula"
      end
      @row << raw_data.xml
    end

    # Creates a reference to a cell in this Worksheet to be used in
    # another Worksheet.
    def reference(args, equal = '=')
      Formula.new("#{equal}'#{name}'!#{LibExcel.static(args[:row], args[:col])}")
    end

    private
    def table
      table = XML::Node.new('Table')
      table['x:FullColumns'] = '1'
      table['x:FullRows'] = '1'
      @table = table
    end
  end
end

class String
  def truncate
    return self if self.length <= 30

    half_length = self.length / 2
    lstring = self[0, half_length].rtruncate(half_length-(half_length-13))
    rstring = self[half_length, self.length].ltruncate(half_length-13)
    lstring << (self.length % 2 != 0 ? "..." : "....") << rstring
    lstring
  end

  def rtruncate(to)
    self[0,to]
  end

  def ltruncate(to)
    self[to, self.length]
  end
end
