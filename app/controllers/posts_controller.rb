class PostsController < ApplicationController
  def index
    @posts = ["First Post", "Second Post", "Third Post"]
  end
end
