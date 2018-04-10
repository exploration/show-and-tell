module ShowAndTell
  class ConditionGenerator
    def initialize(base, name)
      @base = base
      @name = name
    end

    def show_and_tell_when_equals(match_field, fields_to_show = {})
      show_when_equals match_field, fields_to_show
      tell_when_equals match_field, fields_to_show
    end

    def show_when_equals(match_field, fields_to_show = {})
      base_class_map = @base.class_eval('@_show_map')
      base_class_map[@name] ||= {}
      base_class_map[@name][match_field] = fields_to_show
    end

    def tell_when_equals(match_field, fields_to_show = {})
      validate_presence(match_field, fields_to_show) 
    end

    private

      def base_class_validate(field, message, match_field)
        base_field_name = @name
        @base.class_eval do 
          validates_presence_of field, message: message,
            if: proc { |a| a.send(base_field_name) == match_field }
        end
      end

      def validate_presence(match_field, fields_to_show)
        fields_to_show.each { |f, msg| base_class_validate(f, msg, match_field) }
      end
  end
end
