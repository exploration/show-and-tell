require "test_helper"

class FineCheese
  include ActiveModel::Model
  include ShowAndTell

  attr_accessor :age, :cheese, :moldiness, :origin

  validates_presence_of :cheese

  form_option :cheese do |f| 
    f.show_when_matches 'brie',
      age: 'How old is your Brie?'

    f.tell_when_matches /cheddar/i,
      origin: 'Kindly indicate the cheddar country'

    f.show_and_tell_when_matches 'nacho',
      origin: 'Country plz on yer nacho chz'
  end

  form_option :age do |f|
    f.tell_when_matches /42/, moldiness: 'oooh, how moldy is it?'
  end
end

class ShowAndTellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShowAndTell::VERSION
  end

  def test_show_map
    map = FineCheese.show_map
    assert_includes map, :cheese
    assert_includes map[:cheese], 'brie'
    assert_includes map[:cheese], 'nacho'
  end

  def test_show_map_json
    assert_equal(
      "{\"cheese\":{\"brie\":{\"age\":\"How old is your Brie?\"}" +
        ",\"nacho\":{\"origin\":\"Country plz on yer nacho chz\"}}}",
      FineCheese.show_map_json
    )
  end

  def test_indifferent_access
    map = FineCheese.show_map
    assert_includes map, :cheese
    assert_includes map, 'cheese'
    assert_includes map[:cheese], 'brie'
    assert_includes map['cheese'], :brie
  end

  def test_dynamic_validation
    brie = FineCheese.new cheese: nil, age: 42
    refute brie.valid?
    assert_includes brie.errors.messages, :cheese
    assert_includes brie.errors.messages, :moldiness
    assert_equal 'oooh, how moldy is it?', brie.errors.messages[:moldiness].first
    refute_includes brie.errors.messages, :origin

    cheddar = FineCheese.new cheese: 'cheddar'
    refute cheddar.valid?
    assert_includes cheddar.errors.messages, :origin
    assert_equal 'Kindly indicate the cheddar country',
      cheddar.errors.messages[:origin].first
    refute_includes cheddar.errors.messages, :age
  end

  def test_regexp_validation
    cheddar_lc = FineCheese.new(cheese: 'cheddar')
    refute cheddar_lc.valid?
    assert_includes cheddar_lc.errors.messages, :origin

    cheddar_uc = FineCheese.new(cheese: 'ChEdDaR')
    refute cheddar_uc.valid?
    assert_includes cheddar_uc.errors.messages, :origin
  end
end
