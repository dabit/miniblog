module Miniblog
  module Admin
    class BaseController < Miniblog::ApplicationController
      before_filter :authenticate_user!
    end
  end
end
