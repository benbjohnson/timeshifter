require File.dirname(__FILE__) + '/helper'

class TimeshifterTestCase < MiniTest::Unit::TestCase
  ## Initialization ############################################################

  def test_raise_error_for_nil_ranges
    assert_raises RuntimeError do
      shifter = Timeshifter.new(nil)
    end
  end


  ## Total Hours ###############################################################

  def test_should_calculate_total_hours_simple
    shifter = Timeshifter.new([0..12])
    assert_equal 12, shifter.total_hours
  end

  def test_should_calculate_total_hours_complex
    shifter = Timeshifter.new([0..8, 18..24])
    assert_equal 14, shifter.total_hours
  end

  def test_should_calculate_total_hours_for_empty_ranges
    shifter = Timeshifter.new([])
    assert_equal 0, shifter.total_hours
  end


  ## Shifting ##################################################################

  def test_should_shift_to_original_time
    shifter = Timeshifter.new([0..24])
    assert_equal 'Fri Jan 01 12:00:00 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 12, 0, 0)).to_s
  end

  def test_should_shift_simple
    shifter = Timeshifter.new([0..12])
    assert_equal 'Fri Jan 01 04:00:00 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 8, 0, 0)).to_s
  end

  def test_should_shift_complex
    shifter = Timeshifter.new([0..8, 16..24])
    assert_equal 'Fri Jan 01 06:00:00 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 9, 0, 0)).to_s
  end

  def test_should_shift_to_secondary_range
    shifter = Timeshifter.new([0..8, 16..24])
    assert_equal 'Fri Jan 01 16:00:00 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 12, 0, 0)).to_s
  end

  def test_should_shift_to_secondary_range2
    shifter = Timeshifter.new([0..8, 16..24])
    assert_equal 'Fri Jan 01 20:00:00 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 18, 0, 0)).to_s
  end

  def test_should_shift_to_end_of_ranges
    shifter = Timeshifter.new([0..8, 16..24])
    assert_equal 'Fri Jan 01 23:59:59 UTC 2010', shifter.shift(Time.utc(2010, 1, 1, 23, 59, 59)).to_s
  end
end
