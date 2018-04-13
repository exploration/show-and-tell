# frozen_string_literal: true

require "test_helper"

class MonitorTest < Minitest::Test
  def test_constructor
    assert_equal some_monitor.answer, 'brie'
    assert_equal some_monitor.fields_to_show, ['hello', 'world']
  end

  def test_to_h
    expected_hash = { answer: 'brie', fields_to_show: ['hello', 'world'] }
    assert_equal expected_hash, some_monitor.to_h
  end

  def test_add_fields_to_show
    monitor = some_monitor
    monitor.add_fields_to_show 'baz'
    assert_includes monitor.fields_to_show, 'baz'
  end

  private
    def some_monitor
      ShowAndTell::Monitor.new('brie', 'hello', 'world')
    end
end
