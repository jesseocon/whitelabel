module FindNode
  require 'active_support/concern'
  extend ActiveSupport::Concern

  class_methods do
    def find_node(obj, key)
      obj.extend Hashie::Extensions::DeepFind
      obj.deep_find(key)
    end
  end

end