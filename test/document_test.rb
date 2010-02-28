require 'test/helper'

class DocumentTest < Test::Unit::TestCase

  def test_responds_to
    assert LibExcel::Document.respond_to? :new
  end

  def test_doc_name
    doc = LibExcel::Document.new('Doc1')
    assert_equal 'Doc1', doc.name
  end

  def test_change_to_correct_name
    doc = LibExcel::Document.new('Wrong name')
    doc.name = 'Correct Name'
    assert_equal 'Correct Name', doc.name
  end

  def test_adding_a_worksheet
    worksheet = LibExcel::Worksheet.new('worksheet1')
    doc = LibExcel::Document.new('Doc1')
    doc << worksheet
    # TEST isn't finished
  end

  should 'respond to new' do
    assert_respond_to LibExcel::Document, :new
  end

  context 'A document instance' do
    setup do
      @document = LibExcel::Document.new('xls-document')
    end

    should 'respond to <<' do
      assert_respond_to @document, :<<
    end

    should 'add to root' do
      root = @document.send(:root).to_s
      @document.send(:root) << LibXML::XML::Node.new('helo')
      assert_not_equal root, @document.send(:root).to_s
    end

    should 'try to append a XML node' do
      root = @document.send(:root).to_s
      assert_raise ArgumentError do
        @document << LibXML::XML::Node.new('work1')
      end
      assert_equal root, @document.send(:root).to_s
    end

    should 'have its name set' do
      assert_equal 'xls-document', @document.name
    end

    should 'set its name' do
      @document.name = 'change-of-name'
      assert_equal 'change-of-name', @document.name
    end
  end
end
