module Miniblog
  module Admin
    class BaseController < Miniblog::ApplicationController
      before_filter :authenticate_user!

      def after_post_is_saved
      end
    end
  end
end
