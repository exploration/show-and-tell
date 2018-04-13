# frozen_string_literal: true

require 'show_and_tell/condition_generator'
require 'show_and_tell/monitor'
require 'show_and_tell/question'
require 'show_and_tell/question_list'
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
      @show_questions ||= ShowAndTell::QuestionList.new
    end

    def to_a
      show_questions.to_a
    end

    # `show_questions` is handy for passing the conditional logic tree to the front-end portion of this library, which handles showing/hiding divs + fields based on input values.
    def to_json
      show_questions.to_a.to_json
    end
  end
end
