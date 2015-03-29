module Miniblog
  class Admin::PreviewController < Miniblog::Admin::BaseController
    def show
      @post = Post.find(params[:id])
      render '/miniblog/posts/show'
    end
  end
end
