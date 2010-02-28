require 'test/helper'
require 'libxml'

class LibExcel::FormulaTest < Test::Unit::TestCase
  def test_formula
    assert_respond_to LibExcel::Formula, :new
  end

  def test_returns_correct_xml
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=COUNTA(R[10]C[-1]:R[30]C[-1])"

    counta = LibExcel::Formula.counta(:rows => 10..30, :col => -1)

    assert_equal node, counta.xml
  end

  def test_accepting_one_argument
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(R[2]C:R[2]C)"

    assert_equal node, LibExcel::Formula.sum(:rows => 2..2).xml
  end

  def test_accepting_two_arguments
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=MAX(R[1]C[3]:R[2]C[4])"

    assert_equal node, LibExcel::Formula.max(:rows => 1..2, :cols => 3..4).xml
  end

  def test_accepting_random_arguments
    node = LibXML::XML::Node.new('Cell')
    formatted_args, args = generate_excel_grid_combination
    node['ss:Formula'] = "=SUM(#{formatted_args})"

    assert_equal LibExcel::Formula.partition(node), args
  end

  def test_node_correct
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(#{generate_excel_grid_combination.first})"
    assert LibExcel::Formula.node_correct?(node)
  end

  def test_node_with_base_min
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(RC:RC)"
    assert LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "SUM(#{generate_excel_grid_combination.first})"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct2
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM#{generate_excel_grid_combination.first})"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct3
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(#{generate_excel_grid_combination.first}"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct4
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(R[1C:R[10]C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct5
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(R1]C:R[10]C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct6
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(R1C:R[10]C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct7
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(RC:R10]C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct8
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(RC:R10C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_node_is_not_correct9
    node = LibXML::XML::Node.new('Cell')
    node['ss:Formula'] = "=SUM(RC:R[10C)"
    assert !LibExcel::Formula.node_correct?(node)
  end

  def test_respond_to_div
    assert_respond_to LibExcel::Formula.new('=SUM(RC:RC)'), :/
  end

  def test_formula_div
    f1 = LibExcel::Formula.sum(:rows => 1..2)
    f2 = LibExcel::Formula.sum(:rows => 3..4)
    assert_equal '=SUM(R[1]C:R[2]C)/SUM(R[3]C:R[4]C)', (f1/f2).xml['ss:Formula']
  end

  def test_formula_div_perserves_old_formulas
    f1 = LibExcel::Formula.sum(:rows => 1..2)
    f2 = LibExcel::Formula.sum(:rows => 3..4)
    f1/f2
    assert_equal '=SUM(R[1]C:R[2]C)', f1.xml['ss:Formula']
    assert_equal '=SUM(R[3]C:R[4]C)', f2.xml['ss:Formula']
  end

  private
  def generate_excel_grid_combination
    count = rand(3)

    args = []

    selection = case count
                when 0 then args = [1, nil, 3, nil]
                when 1 then args = [nil, 2, nil, 4]
                when 2 then args = [1, 2, 3, 4]
                end

    selection = args.clone

    formatted_args = ['R', 'C', 'R', 'C'].collect { |x|
        arg = args.shift
        if !arg.nil?
          x + "[#{arg}]"
        else
          x    
        end
    }.insert(2, ':').join('')
    return formatted_args, selection
  end

end
