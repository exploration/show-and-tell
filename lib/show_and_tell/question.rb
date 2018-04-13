# frozen_string_literal: true

module ShowAndTell
  class Question
    attr_reader :question

    def initialize(question)
      @question = question
      @monitors = Set.new
    end

    def find_or_add_monitor(answer)
      @monitors.find { |m| m.answer == answer } ||
        add_monitor(ShowAndTell::Monitor.new(answer))
    end

    def to_h
      { question: @question, monitors: @monitors.map { |m| m.to_h } }
    end

    private

      def add_monitor(monitor)
        @monitors.add monitor
        monitor
      end
  end
end
