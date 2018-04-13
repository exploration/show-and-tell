# frozen_string_literal: true

require "test_helper"

class QuestionListTest < Minitest::Test
  def test_constructor_and_basic_to_a
    assert_equal [], some_question_list.to_a
  end

  def test_find_or_add_question
    question = some_question_list.find_or_add_question 'cheese'
    assert_kind_of ShowAndTell::Question, question
    assert_equal question.question, 'cheese'
  end

  def test_to_a
    question_list = some_question_list
    question = question_list.find_or_add_question 'cheese'
    expected_a = [{ question: 'cheese', monitors: [] }]
    assert_equal expected_a, question_list.to_a
  end


  private
    def some_question_list
      ShowAndTell::QuestionList.new
    end
end
