require 'show_and_tell/register_helper'

module ShowAndTell
  class Railtie < Rails::Railtie
    initializer 'show_and_tell_register.helper' do |app|
      ActionView::Base.send :include, ShowAndTellRegisterHelper
    end
  end
end
