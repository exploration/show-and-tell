module ShowAndTell
  class ConditionGenerator
    attr_reader :name

    def initialize(base, name)
      @base = base
      @name = name
    end

    def show_when_equals(match_value, fields_to_show = {})
      map_when_equals '@_show_map', match_value, fields_to_show
    end

    def tell_when_equals(match_value, fields_to_show = {})
      map_when_equals '@_tell_map', match_value, fields_to_show
    end

    def show_and_tell_when_equals(match_value, fields_to_show = {})
      show_when_equals match_value, fields_to_show
      tell_when_equals match_value, fields_to_show
    end

    private
      def map_when_equals(map, match_value, fields_to_show)
        @base.class_eval(map)[@name] ||= {}
        @base.class_eval(map)[@name][match_value] = fields_to_show
      end
  end
end
