class Miniblog::Admin::StatesController < Miniblog::Admin::BaseController
  def update
    @post = Miniblog::Post.find(params[:post_id])
    if @post.published?
      @post.draft
    else
      @post.publish
    end
    redirect_to admin_posts_path
  end
end
