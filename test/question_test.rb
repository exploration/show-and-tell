# frozen_string_literal: true

require "test_helper"

class QuestionTest < Minitest::Test
  def test_constructor
    assert_equal some_question.question, 'cheese'
  end

  def test_find_or_add_monitor
    question = some_question
    monitor = question.find_or_add_monitor 'brie'
    assert_kind_of ShowAndTell::Monitor, monitor
    assert_equal monitor.answer, 'brie'
  end

  def test_to_h
    question = some_question
    question.find_or_add_monitor 'brie'
    expected_hash = { question: 'cheese', monitors: [{answer: 'brie', fields_to_show: []}] }
    assert_equal expected_hash, question.to_h
  end


  private
    def some_question
      ShowAndTell::Question.new('cheese')
    end
end
