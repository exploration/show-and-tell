# We want to add the ShowAndTell view helper by default
ActiveSupport.on_load(:action_view_base) { include ShowAndTellRegisterHelper }
