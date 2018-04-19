module ShowAndTellRegisterHelper
  def show_and_tell_register(klass)
    <<~TEMPLATE
      <script>
        show_and_tell.register("#{klass}", #{klass.show_and_tell_json})
      </script>
    TEMPLATE
  end 
end
