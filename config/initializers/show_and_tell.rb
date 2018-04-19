# We want to add the ShowAndTell view helper by default
ActionView::Base.send(:include, ShowAndTellRegisterHelper)
