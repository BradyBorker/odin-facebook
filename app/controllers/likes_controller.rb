class LikesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])

        if @post.likes.where(user_id: current_user.id).any?
            destroy
        else
            @like = @post.likes.create(user_id: current_user.id)
            redirect_back fallback_location: root_path
        end
    end

    def destroy
        @like = @post.likes.find_by(user_id: current_user.id)
        @like.destroy
        redirect_back fallback_location: root_path
    end
end
