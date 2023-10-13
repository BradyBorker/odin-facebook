class LikesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])

        # if @post.likes.where(user_id: current_user.id).any?
        #    destroy
        # else
        #    @like = @post.likes.create(user_id: current_user.id)
        #    update_counter_text
        # end
    end

    def destroy
        # @like = @post.likes.find_by(user_id: current_user.id)
        # @like.destroy

        # update_counter_text
    end

    private

    def update_counter_text
        render turbo_stream:
            turbo_stream.replace("counter_#{@post.id}",
                partial: 'likes/like_counter',
                locals: { post: @post })
    end
end
