module Miniblog
  module Admin
    class PostsController < Miniblog::Admin::BaseController
      before_filter :load_post, :only => [ :edit, :update, :destroy ]

      def new
        @post = Post.new
        @post.state = :drafted
        @post.author = current_user
      end

      def index
        @state = params[:state]
        @posts = Post.for_admin_index
        @posts = @posts.with_state(@state) if @state
      end

      def create
        @post = Post.new(post_params)
        @post.state = :drafted
        @post.author = current_user
        @post.regenerate_permalink
        if @post.save
          redirect_to miniblog.edit_admin_post_path(@post), notice: "Post created succesfully"
        else
          render action: :new
        end
      end

      def destroy
        @post.destroy
        redirect_to miniblog.admin_posts_path
      end

      def show
        @post = Post.includes(:assets).find(params[:id])
      end

      def edit
      end

      def update
        if @post.update_attributes(post_params)
          if @post.allowed_to_update_permalink?
            @post.regenerate_permalink
            @post.save!
          end
          flash[:notice] = "Post updated succesfully"
        end
        render action: :edit
      end

      private
      def load_post
        @post = Post.scoped_for(current_user).find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :updated_by, :ready_for_review, :transition)
      end
    end
  end
end
