module LibExcel

  # The Document class manages the document section of the Excel XML file.
  class Document < LibXML::XML::Document
    include LibXML

    attr_accessor :name

    # Creates the Document object. Calls the +super()+ to get the basics of a
    # XML document. +name+ is the name of the document.
    def initialize(name)
      super()

      @name = name
      build_document
      build_root
    end

    # Appends a worksheet to a Document.  Requires that they worksheet being
    # appended to the document be a Worksheet.
    #
    # @return [Document] the Full XML document
    def <<(worksheet)
      if not worksheet.is_a? Worksheet
        raise ArgumentError, "Need to have a Excel::Worksheet"
      end
      root << worksheet
    end

    private
      def root
        super
      end

      # Setup the common Excel URIs in the root.
      def build_document
        self.root = XML::Node.new('Workbook')
        root['xmlns'] = 'urn:schemas-microsoft-com:office:spreadsheet'
        root['xmlns:o'] = 'urn:schemas-microsoft-com:office:office'
        root['xmlns:x'] = 'urn:schemas-microsoft-com:office:excel'
        root['xmlns:ss'] = 'urn:schemas-microsoft-com:office:spreadsheet'
        root['xmlns:html'] = 'http://www.w3.org/TR/REC-html40'
      end

      # Setup the document properties of the document.
      def build_root
        root << document_properties = XML::Node.new('DocumentProperties')
        document_properties['xmlns'] = 'urn:schemas-microsoft-com:office:office'

        document_properties << author = XML::Node.new('Author')
        author << 'Scarlet'
        document_properties << last_author = XML::Node.new('LastAuthor')
        last_author << 'Scarlet'
        document_properties << version = XML::Node.new('Version')
        version << '12.256'

        root << office_document_settings = XML::Node.new('OfficeDocumentSettings')
        office_document_settings['xmlns'] = 'urn:schemas-microsoft-com:office:office'
        office_document_settings << XML::Node.new('AllowPNG')

        root << excel_workbook = XML::Node.new('ExcelWorkbook')
        excel_workbook['xmlns'] = 'urn:schemas-microsoft-com:office:excel'

        excel_workbook << window_height = XML::Node.new('WindowHeight', '20260')
        excel_workbook << window_width = XML::Node.new('WindowWidth', '29600')
        excel_workbook << window_top_x = XML::Node.new('WindowTopX', '3440')
        excel_workbook << window_top_y = XML::Node.new('WindowTopY', '-80')
        excel_workbook << XML::Node.new('Date1904')
        excel_workbook << XML::Node.new('ProtectStructure', 'False')
        excel_workbook << XML::Node.new('ProtectWindows', 'False')

        root << styles = XML::Node.new('Styles')
        styles << style = XML::Node.new('Style')
        style['ss:ID'] = 'Default'
        style['ss:Name'] = 'Normal'
        style << alignment = XML::Node.new('Alignment')
        alignment['ss:Vertical'] = 'Bottom'
        style << XML::Node.new('Borders')
        style << font = XML::Node.new('Font')
        font['ss:FontName'] = 'Verdana'
        style << XML::Node.new('Interior')
        style << XML::Node.new('NumberFormat')
        style << XML::Node.new('Protection')
      end
  end
end
