# frozen_string_literal: true

require "test_helper"

class FineCheese
  include ActiveModel::Model
  include ShowAndTell

  attr_accessor :age, :cheese, :moldiness, :origin

  validates_presence_of :cheese

  form_option :cheese do |f|
    f.show_when_matches 'brie', :age

    f.tell_when_matches 'cheddar',
      origin: 'Kindly indicate the cheddar country'

    f.show_and_tell_when_matches 'nacho',
      origin: 'Country plz on yer nacho chz'
  end

  form_option :age do |f|
    f.tell_when_matches '[4-9]\d+', moldiness: 'oooh, how moldy is it?'
  end
end

class ShowAndTellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShowAndTell::VERSION
  end

  def test_to_a
    question_list = FineCheese.to_a
    assert_equal 1, question_list.length
    assert_includes question_list.first, :question
  end

  def test_to_json
    assert_equal(
      "[{\"question\":\"cheese\",\"monitors\":[{\"answer\":\"brie\",\"fields_to_show\":[\"age\"]},{\"answer\":\"nacho\",\"fields_to_show\":[\"origin\"]}]}]",
      FineCheese.to_json
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
