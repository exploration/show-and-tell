require 'show_and_tell/condition_generator'
require 'show_and_tell/version'

require 'active_model'
require 'active_support/concern'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'

module ShowAndTell
  extend ActiveSupport::Concern

  class_methods do
    def form_option(field_name)
      @_show_map ||= {}
      yield ConditionGenerator.new(self, field_name)
    end

    def show_map
      ActiveSupport::HashWithIndifferentAccess.new @_show_map
    end

    def show_map_json
      show_map.to_json
    end
  end
end
