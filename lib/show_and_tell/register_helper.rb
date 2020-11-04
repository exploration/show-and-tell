module ShowAndTellRegisterHelper
  def show_and_tell_register(klass, turbolinks: false)
    tl_open = 'document.addEventListener("turbolinks:load", () => {'
    tl_close = '})'
    template = <<~TEMPLATE
      <script>
        #{tl_open if turbolinks}
        show_and_tell.register("#{klass}", #{klass.show_and_tell_json})
        #{tl_close if turbolinks}
      </script>
    TEMPLATE
    defined?(raw) ? raw(template) : template
  end 
end
