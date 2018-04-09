require "test_helper"

class FineCheese
  include ActiveModel::Model
  include ShowAndTell

  attr_accessor :age, :cheese, :moldiness, :origin

  form_option :cheese do |f| 
    f.show_when_equals 'brie', { age: 'How old is your Brie?' }

    f.tell_when_equals 'cheddar', {
      origin: 'Kindly indicate the cheddar country'
    }

    f.show_and_tell_when_equals 'nacho', {
      origin: 'Country plz on yer nacho chz'
    }
  end

  form_option :age do |f|
    f.tell_when_equals 42, moldiness: 'oooh, how moldy is it?'
  end
end

class ShowAndTellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShowAndTell::VERSION
  end

  def test_show_map
    map = FineCheese.show_and_tell_map
    assert_includes map, :show
    assert_includes map[:show], :cheese
    assert_includes map[:show][:cheese], 'brie'
    assert_includes map[:show][:cheese], 'nacho'
  end

  def test_tell_map
    map = FineCheese.show_and_tell_map
    assert_includes map, :tell
    assert_includes map[:tell], :cheese
    assert_includes map[:tell][:cheese], 'cheddar'
    assert_includes map[:tell][:cheese], 'nacho'
    assert_includes map[:tell][:age], 42
  end

  def test_indifferent_access
    map = FineCheese.show_and_tell_map
    assert_includes map, :show
    assert_includes map, 'show'
    assert_includes map[:show], :cheese
    assert_includes map['show'], 'cheese'
  end
end
