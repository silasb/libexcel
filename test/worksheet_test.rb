require 'test/helper'

class WorksheetTest < Test::Unit::TestCase

  def test_responds_to
    assert LibExcel::Worksheet.respond_to? :new
  end

  context 'A worksheet instance' do
    setup do
      @worksheet = LibExcel::Worksheet.new('Worksheet1')
    end

    should 'have it\'s name set' do
      assert_equal 'Worksheet1', @worksheet.name
    end

    should 'respond to' do
      assert @worksheet.respond_to? :add_row
      assert @worksheet.respond_to? :add_cell
      assert @worksheet.respond_to? :add_array
      assert @worksheet.respond_to? :<<
      assert @worksheet.respond_to? :reference
    end

    should 'change name' do
      @worksheet.name = 'new name'
      assert_equal 'new name', @worksheet.name
    end

    should 'truncate name 31 chars' do
      @worksheet.name = '12345678901234567890123456789012' # 31
      assert_equal '1234567890123....0123456789012', @worksheet.name
      @worksheet.name = '123456789012345678901234567890112312312312312312312'
      assert_equal '1234567890123...12312312312312', @worksheet.name
      @worksheet.name = '1'
      assert_equal '1', @worksheet.name
    end

    context 'adds data' do
      setup do
        @worksheet.add_row
      end

      should 'add string data' do
        data = @worksheet.add_cell 'hello'
        assert_equal 'hello', data.content
        assert_equal 'String', data['ss:Type']
      end

      should 'add number data' do
        data = @worksheet.add_cell 1
        assert_equal 1.to_s, data.content
        assert_equal 'Number', data['ss:Type']
      end

      should 'add float data' do
        data = @worksheet.add_cell 1.1
        assert_equal 1.1.to_s, data.content
        assert_equal 'Number', data['ss:Type']
      end

      should 'add nil data' do
        data = @worksheet.add_cell nil
        assert_equal nil, data
      end
    end
  end

  should 'return the default column width' do
    assert_equal '100', LibExcel::Worksheet::DEFAULT_COLUMN_WIDTH
  end

  context 'A worksheet instance' do
    setup do
      @work = LibExcel::Worksheet.new('Worksheet 1')
    end

    should 'respond to reference' do
      assert_respond_to LibExcel::Worksheet.new('Worksheet 1'), :reference
    end

    should 'return its name' do
      assert_equal 'Worksheet 1', @work.name
    end

    should 'set its name' do
      @work.name='New Name'
      assert_equal 'New Name', @work.name
    end

    context 'assigning a name over 30 chars' do
      should 'make sure that you can not add a name over 30 chars' do
        @work.name='ThisStringIsClearlyOverThirtyChars'
        assert_equal 'ThisStringIsC....erThirtyChars', @work.name
      end

      should 'make sure that it gives 3 dots when odd' do
        @work.name='ThisStringIsClearlyOverThirtyCharss'
        assert_equal 'ThisStringIsC...erThirtyCharss', @work.name
      end

      should 'make sure that it gives 4 dots when even' do
        @work.name='ThisStringIsClearlyOverThirtyCha'
        assert_equal 'ThisStringIsC....OverThirtyCha', @work.name
      end

      should 'be less than 30 chars' do
        @work.name='ThisStringIsClearlyOver'
        assert_equal 'ThisStringIsClearlyOver', @work.name
      end
    end

    should 'return its column width' do
      assert_equal LibExcel::Worksheet::DEFAULT_COLUMN_WIDTH, @work.f_column
    end

    should 'set its column width' do
      @work.f_column=50
      assert_equal '50', @work.f_column
    end

    should 'set a reference' do
      assert_equal "<Cell ss:Formula=\"='Worksheet 1'!R[1]C[2]\"/>",
        @work.reference(:row => 1, :col => 2).xml.to_s
    end

    should 'set a reference with no equal sign' do
      assert_equal "<Cell ss:Formula=\"'Worksheet 1'!R[1]C[2]\"/>",
        @work.reference({:row => 1, :col => 2}, nil).xml.to_s
    end

    should 'set a reference with no col' do
      assert_equal "<Cell ss:Formula=\"='Worksheet 1'!R[1]C\"/>",
        @work.reference(:row => 1).xml.to_s
    end

    should 'set a reference with no col and no equal' do
      assert_equal "<Cell ss:Formula=\"'Worksheet 1'!R[1]C\"/>",
        @work.reference({:row => 1}, nil).xml.to_s
    end

    should 'set a reference with no row' do
      assert_equal "<Cell ss:Formula=\"='Worksheet 1'!RC[1]\"/>",
        @work.reference(:col => 1).xml.to_s
    end

    should 'set a reference with no row and no equal' do
      assert_equal "<Cell ss:Formula=\"'Worksheet 1'!RC[1]\"/>",
        @work.reference({:col => 1}, nil).xml.to_s
    end

    should 'should not allow a reference to be set with no row or col' do
      begin
        @work.reference().xml.to_s
      rescue ArgumentError
        assert true
      end
    end
  end

  context 'A worksheet with a very long name' do
    setup do
      @work = LibExcel::Worksheet.new('ThisStringIsClearlyOverThirtyChars')
    end

    should 'have its name set to 30 chars' do
      assert_equal 'ThisStringIsC....erThirtyChars', @work.name
    end

    should 'make a reference that has its name set to 30 chars' do
      assert_equal 'ThisStringIsC....erThirtyChars',
        @work.reference(:row => 1).xml['ss:Formula'].split("'")[1]
    end

    should 'set name really small and see if it will also change a reference' do
      @work.name = 'A Short Name'
      assert_equal 'A Short Name',
        @work.reference(:row => 1).xml['ss:Formula'].split("'")[1]
    end
  end

  context 'creating a worksheet with a name over 30 chars' do
    should 'make sure that you can not add a name over 30 chars' do
      @work = LibExcel::Worksheet.new('ThisStringIsClearlyOverThirtyChars')
      assert_equal 'ThisStringIsC....erThirtyChars', @work.name
    end

    should 'make sure that it gives 3 dots when odd' do
      @work = LibExcel::Worksheet.new('ThisStringIsClearlyOverThirtyCharss')
      assert_equal 'ThisStringIsC...erThirtyCharss', @work.name
    end

    should 'make sure that it gives 4 dots when even' do
      @work = LibExcel::Worksheet.new('ThisStringIsClearlyOverThirtyCha')
      assert_equal 'ThisStringIsC....OverThirtyCha', @work.name
    end

    should 'be less than 30 chars' do
      @work = LibExcel::Worksheet.new('ThisStringIsClearlyOver')
      assert_equal 'ThisStringIsClearlyOver', @work.name
    end
  end
end
