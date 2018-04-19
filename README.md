# ShowAndTell

If you've ever had Rails forms with front-end logic that shows or hides form values conditionally on what's entered on the form, and then back-end validation that mirrors that logic, then boy do we have a gem for you!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'show_and_tell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install show_and_tell

## Usage

TODO: Write usage instructions here

### Javascript Front-End

To use the Javascript front-end, you'll need to add the following to your `app/assets/javascripts/application.js` file:

```javascript
//= require show_and_tell
```

Then, in your HTML, probably in the header just before the body:

```html
<script> 
  const show_and_tell = new ShowAndTell
</script>
```

And at the bottom of every form that you wish to monitor, you can insert the magic incantation to inject monitoring:

```html
<%= show_and_tell_register MyFormClass %>
```

... where `MyFormClass` is the class name of the form being monitored (for example, `ParentCommentForm` or `CourseForm`, etc.).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

TODO: update with proper data
Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/show_and_tell. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ShowAndTell project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/show_and_tell/blob/master/CODE_OF_CONDUCT.md).
