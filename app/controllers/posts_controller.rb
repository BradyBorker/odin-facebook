class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @post = Post.new
        @comment = Comment.new
        # TODO: Make this so only current user's posts and friend's posts are grabbed
        @posts = Post.includes(:comments, :likes, user: :user_information).limit(10).order(created_at: :desc)
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:notice] = 'Post Created Successfully'
            redirect_to root_path
        else
            flash[:alert] = 'Post Not Created'
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:body)
    end
end
