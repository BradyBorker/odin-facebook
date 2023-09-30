class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.includes(:comments, :likes, user: :user_information).limit(10)
    end

    def new
        @post = Post.new
    end

    def create
    end
end
