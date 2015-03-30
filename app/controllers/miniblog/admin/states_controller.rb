class Miniblog::Admin::StatesController < Miniblog::Admin::BaseController
  def update
    @post = Miniblog::Post.find(params[:post_id])
    if @post.published?
      @post.draft
      after_post_is_saved
    else
      @post.publish
      after_post_is_saved
    end
    redirect_to admin_posts_path
  end
end
