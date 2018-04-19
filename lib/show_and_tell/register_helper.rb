module ShowAndTellRegisterHelper
  def show_and_tell_register(klass)
    template = <<~TEMPLATE
      <script>
        show_and_tell.register("#{klass}", #{klass.show_and_tell_json})
      </script>
    TEMPLATE
    defined?(Rails) ? raw(template) : template
  end 
end
