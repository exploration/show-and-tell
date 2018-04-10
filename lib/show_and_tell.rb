# frozen_string_literal: true

require 'show_and_tell/condition_generator'
require 'show_and_tell/version'

require 'active_model'
require 'active_support/concern'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'

# Class methods to be included into any `ActiveModel` class that needs trees of
# conditional validation.
module ShowAndTell
  extend ActiveSupport::Concern

  class_methods do

    def form_option(field_name)
      @_show_map ||= {}
      yield ConditionGenerator.new(self, field_name)
    end

    # You will call `MyClass.show_map` when you want to get a hash representing your conditional logic tree.
    def show_map
      ActiveSupport::HashWithIndifferentAccess.new @_show_map
    end

    # `show_map_json` is handy for passing the conditional logic tree to the front-end portion of this library, which handles showing/hiding divs + fields based on input values.
    def show_map_json
      show_map.to_json
    end
  end
end
