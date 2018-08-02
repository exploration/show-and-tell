# frozen_string_literal: true

require "test_helper"
require "show_and_tell/register_helper"
include ShowAndTellRegisterHelper

class RegisterHelperTest < Minitest::Test
  def test_it
    expected_result = <<~ER
      <script>
        
        #{blob}
        
      </script>
    ER
    assert_equal show_and_tell_register(FineCheese), expected_result
  end

  def test_turbolinks
    expected_result = <<~ER
      <script>
        document.addEventListener("turbolinks:load", () => {
        #{blob}
        })
      </script>
    ER
    assert_equal show_and_tell_register(FineCheese, turbolinks: true), expected_result
  end

  private

    def blob
      'show_and_tell.register("FineCheese", [{"question":"cheese","monitors":[{"answer":"brie","fields_to_show":["age"]},{"answer":"nacho","fields_to_show":["origin"]}]}])'
    end
end
