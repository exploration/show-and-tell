# frozen_string_literal: true

module ShowAndTell
  # To use 'ShowAndTell', you call 'form_option' for each field you want to monitor (in the class definition of the model), and pass it a block of options. The object you're referencing in the block is a 'ConditionGenerator', so the methods for monitoring + matching all live here.
  #
  # Typical Usage:
  #
  #     form_option :my_field do |f|
  #       f.show_when_matches('value_to_match', field: 'validation_message')
  #     end
  #
  # More usage patterns can be found in the test suite.
  class ConditionGenerator
    # You don't typically initialize one of these manually. It gets called from 'ShowAndTell.form_option'.
    def initialize(base, field_name)
      @base = base
      @field_name = field_name
    end

    # "Show" this field, and also validate its existence, when the contents of '@field_name' in the '@base' class match 'regexp_str'.
    # @param regexp_str [String] - A string, optionally containing Regexp incantations, defining what counts as a match for display or validation.
    # @param fields_to_show [Hash] - Field name and validation message pairs.
    def show_and_tell_when_matches(regexp_str, **fields_to_show)
      show_when_matches regexp_str, fields_to_show
      tell_when_matches regexp_str, fields_to_show
    end

    # Same as 'show_and_tell_when_matches', except only for front-end display.
    def show_when_matches(regexp_str, **fields_to_show)
      questions = @base.class_eval('show_questions')
      questions[@field_name] ||= {}
      questions[@field_name][regexp_str] = fields_to_show
    end

    # Same as 'show_and_tell_when_matches', except only for model validation.
    def tell_when_matches(regexp_str, **fields_to_show)
      validate_presence(regexp_str, fields_to_show)
    end

    private

      def base_class_validate(field, msg, regexp_str)
        base_field_name = @field_name
        validation_logic = proc { |instance|
            field_value = instance.send(base_field_name)
            field_value.nil? ? false : /#{regexp_str}/i.match(field_value.to_s)
          }

        @base.class_eval do |b|
          validates_presence_of field, message: msg, if: validation_logic
        end
      end

      def validate_presence(regexp_str, fields_to_show)
        fields_to_show.each { |f, msg| base_class_validate(f, msg, regexp_str) }
      end
  end
end
