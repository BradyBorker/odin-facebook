class LikesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        update_like if @post.likes.create(user_id: current_user.id)
    end

    def destroy
        @like = Like.find_by(post_id: params[:post_id], user_id: params[:id])
        @like.destroy
        update_like
    end

    private

    def update_like
        @post ||= Post.find(params[:post_id])

        render turbo_stream:
            turbo_stream.replace("like_#{@post.id}",
                partial: 'likes/like',
                locals: { post: @post })
    end
end
