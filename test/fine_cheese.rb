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
