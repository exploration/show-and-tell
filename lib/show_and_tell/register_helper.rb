module ShowAndTellRegisterHelper
  def show_and_tell_register(klass)
    <<~JAVASCRIPT
      <script>
        show_and_tell.register("#{klass}", #{klass.show_and_tell_json})
      </script>
    JAVASCRIPT
  end 
end
