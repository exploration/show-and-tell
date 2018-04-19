# frozen_string_literal: true

require 'show_and_tell/condition_generator'
require 'show_and_tell/engine' if defined?(Rails)
require 'show_and_tell/monitor'
require 'show_and_tell/question'
require 'show_and_tell/question_list'
require 'show_and_tell/version'

require 'active_model'
require 'active_support/concern'
require 'json'


# Class methods to be included into any `ActiveModel` class that needs trees of
# conditional validation.
module ShowAndTell
  extend ActiveSupport::Concern

  class_methods do
    def form_option(field_name)
      yield ConditionGenerator.new(self, field_name)
    end

    def show_and_tell_questions
      @show_and_tell_questions ||= ShowAndTell::QuestionList.new
    end

    def show_and_tell_list
      show_and_tell_questions.to_a
    end

    # `show_and_tell_json` is handy for passing the conditional logic tree to the front-end portion of this library, which handles showing/hiding divs + fields based on input values.
    def show_and_tell_json
      show_and_tell_list.to_json
    end
  end
end
