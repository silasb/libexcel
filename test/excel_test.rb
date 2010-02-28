require 'test/helper'

class LibExcelTest < Test::Unit::TestCase

  # range tests

  def test_range_respond_to
    assert_respond_to LibExcel, :range
  end

  def test_range_rows
    assert_equal "R[1]C:R[3]C", LibExcel.range(:rows => 1..3)
  end

  def test_backwards_range_rows
    assert_equal "R[3]C:R[1]C", LibExcel.range(:rows => 3..1)
  end

  def test_backwards_negative_range_rows
    assert_equal "R[-3]C:R[1]C", LibExcel.range(:rows => -3..1)
  end

  def test_range_rows_with_col
    assert_equal "R[1]C[1]:R[3]C[1]", LibExcel.range(:rows => 1..3, :col => 1)
  end

  def test_backwards_range_rows_with_col
    assert_equal "R[3]C[1]:R[1]C[1]", LibExcel.range(:rows => 3..1, :col => 1)
  end

  def test_range_cols
    assert_equal "RC[1]:RC[2]", LibExcel.range(:cols => 1..2)
  end

  def test_backwards_range_cols
    assert_equal "RC[2]:RC[1]", LibExcel.range(:cols => 2..1)
  end

  def test_backwards_negative_range_cols
    assert_equal "RC[-2]:RC[1]", LibExcel.range(:cols => -2..1)
  end

  def test_range_cols_with_row
    assert_equal "R[3]C[1]:R[3]C[2]", LibExcel.range(:cols => 1..2, :row => 3)
  end

  def test_range_cols_with_rows
    assert_equal "R[1]C[2]:R[3]C[4]", LibExcel.range(:cols => 2..4, :rows => 1..3)
  end

  # static tests

  def test_static_respond_to
    assert_respond_to LibExcel, :static
  end

  def test_static_row
    assert_equal "R[1]C", LibExcel.static(1, nil)
  end

  def test_static_negative_row
    assert_equal "R[-2]C", LibExcel.static(-2, nil)
  end

  def test_static_row_with_col
    assert_equal "R[1]C[2]", LibExcel.static(1,2)
  end

  def test_static_col
    assert_equal "RC[1]", LibExcel.static(nil,1)
  end

  def test_static_negative_col
    assert_equal "RC[-2]", LibExcel.static(nil,-2)
  end

end
