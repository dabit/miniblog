class Miniblog::SitemapController < ApplicationController
  def show
    @posts = Miniblog::Post.published_and_ordered
  end
end
