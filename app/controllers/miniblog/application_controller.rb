module Miniblog
  class ApplicationController < ::ApplicationController
    def method_missing(method_name)
      if method_name == :current_user
        Rails.logger.warn("current_user in Miniblog::ApplicationController should be overriden")
        ::User.new
      elsif method_name == :authenticate_user!
        Rails.logger.warn("authenticate_user! in Miniblog::ApplicationController should be overriden")
      end
    end

    helper_method :current_user
  end
end
