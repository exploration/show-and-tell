module ShowAndTell
  class Monitor
    attr_accessor :answer

    def initialize(answer, *fields_to_show)
      @answer = answer
      @fields_to_show = Set.new(fields_to_show)
    end

    def add_fields_to_show(*field_names)
      @fields_to_show = @fields_to_show.union field_names
    end

    def fields_to_show
      @fields_to_show.to_a
    end

    def to_h
      { answer: @answer, fields_to_show: @fields_to_show.to_a }
    end
  end
end
