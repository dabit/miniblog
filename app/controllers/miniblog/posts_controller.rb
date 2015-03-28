module Miniblog
  class PostsController < ApplicationController
    def index
      @posts = Post.published_and_ordered
    end
  end
end
