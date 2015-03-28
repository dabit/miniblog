module Miniblog
  class StatusChangeRecord < ActiveRecord::Base
    belongs_to :post
    belongs_to :user, class_name: Miniblog.publisher_user_class_name
  end
end
