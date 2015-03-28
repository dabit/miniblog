module Miniblog
  module Devise
    class FailureApp < ::Devise::FailureApp
      def redirect_url
        miniblog.new_user_session_path
      end
    end
  end
end
