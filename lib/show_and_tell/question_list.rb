# frozen_string_literal: true

module ShowAndTell
  class QuestionList
    def initialize
      @question_list = Set.new
    end

    def find_or_add_question(question)
      @question_list.find { |m| m.question == question } ||
        add_question(ShowAndTell::Question.new(question))
    end

    def to_a
      @question_list.map { |q| q.to_h }
    end

    private
      def add_question(question)
        @question_list.add question
        question
      end
  end
end
