# frozen_string_literal: true

require "test_helper"
require "fine_cheese"

class ShowAndTellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShowAndTell::VERSION
  end

  def test_to_list
    question_list = FineCheese.show_and_tell_list
    assert_equal 1, question_list.length
    assert_includes question_list.first, :question
  end

  def test_to_json
    assert_equal(
      "[{\"question\":\"cheese\",\"monitors\":[{\"answer\":\"brie\",\"fields_to_show\":[\"age\"]},{\"answer\":\"nacho\",\"fields_to_show\":[\"origin\"]}]}]",
      FineCheese.show_and_tell_json
    )
  end

  def test_dynamic_validation
    cheddar = FineCheese.new cheese: 'cheddar'
    refute cheddar.valid?
    assert_includes cheddar.errors.messages, :origin
    assert_equal 'Kindly indicate the cheddar country',
      cheddar.errors.messages[:origin].first
    refute_includes cheddar.errors.messages, :age
  end

  def test_regexp_validation
    brie = FineCheese.new cheese: nil, age: 42
    refute brie.valid?
    assert_includes brie.errors.messages, :cheese
    assert_includes brie.errors.messages, :moldiness
    assert_equal 'oooh, how moldy is it?', brie.errors.messages[:moldiness].first
    refute_includes brie.errors.messages, :origin
  end

  def test_case_insensitive_validation
    cheddar_lc = FineCheese.new(cheese: 'cheddar')
    refute cheddar_lc.valid?
    assert_includes cheddar_lc.errors.messages, :origin

    cheddar_uc = FineCheese.new(cheese: 'ChEdDaR')
    refute cheddar_uc.valid?
    assert_includes cheddar_uc.errors.messages, :origin
  end
end
