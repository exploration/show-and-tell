module ShowAndTell
  class ConditionGenerator
    def initialize(base, name)
      @base = base
      @name = name
    end

    def show_and_tell_when_matches(matchable, **fields_to_show)
      show_when_matches matchable, fields_to_show
      tell_when_matches matchable, fields_to_show
    end

    def show_when_matches(matchable, **fields_to_show)
      show_map = @base.class_eval('@_show_map')
      show_map[@name] ||= {}
      show_map[@name][matchable] = fields_to_show
    end

    def tell_when_matches(matchable, **fields_to_show)
      validate_presence(matchable, fields_to_show) 
    end

    private

      def base_class_validate(field, msg, matchable)
        base_field_name = @name
        validation_logic = proc { |instance| 
            field_value = instance.send(base_field_name)
            field_value.nil? ? false : matchable.match(field_value.to_s)
          }

        @base.class_eval do |b| 
          validates_presence_of field, message: msg, if: validation_logic
        end
      end

      def validate_presence(matchable, fields_to_show)
        fields_to_show.each { |f, msg| base_class_validate(f, msg, matchable) }
      end
  end
end
