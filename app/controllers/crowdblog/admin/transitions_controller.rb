module Crowdblog
  module Admin
    class TransitionsController < Crowdblog::Admin::BaseController
      before_filter :load_post, only: [:create]

      def create
        namespace = '_as_publisher' if current_user.is_publisher?
        @post.send "#{params[:transition]}#{namespace}"
        status = @post.status_change_records.build(user: current_user, state: params[:transition])
        status.save
        redirect_to admin_posts_path
      end

      private

      def load_post
        post  = Post.scoped_for(current_user).find(params[:id])
        @post = PostPresenter.new(post, current_user)
      end
    end
  end
end
