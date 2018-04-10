module ShowAndTell
  class ConditionGenerator
    def initialize(base, name)
      @base = base
      @name = name
    end

    def show_and_tell_when_equals(match_field, **fields_to_show)
      show_when_equals match_field, fields_to_show
      tell_when_equals match_field, fields_to_show
    end

    def show_when_equals(match_field, **fields_to_show)
      show_map = @base.class_eval('@_show_map')
      show_map[@name] ||= {}
      show_map[@name][match_field] = fields_to_show
    end

    def tell_when_equals(match_field, **fields_to_show)
      validate_presence(match_field, fields_to_show) 
    end

    private

      def base_class_validate(field, msg, match_field)
        base_field_name = @name
        @base.class_eval do 
          validates_presence_of field, message: msg,
            if: proc { |a| a.send(base_field_name) == match_field }
        end
      end

      def validate_presence(match_field, fields_to_show)
        fields_to_show.each { |f, msg| base_class_validate(f, msg, match_field) }
      end
  end
end
