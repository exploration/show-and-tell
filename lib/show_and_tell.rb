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
      yield ConditionGenerator.new(self, field_name)
    end

    def show_questions
      @show_questions ||= {}
    end

    # You will call `MyClass.show_questions` when you want to get a hash representing your conditional logic tree.
    def to_h
      ActiveSupport::HashWithIndifferentAccess.new show_questions
    end

    # `show_questions` is handy for passing the conditional logic tree to the front-end portion of this library, which handles showing/hiding divs + fields based on input values.
    def to_json
      show_questions.to_json
    end
  end
end
