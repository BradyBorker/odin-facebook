class LikesController < ApplicationController
    def create
        @parent = parent
        update_like if @parent.likes.create(user_id: current_user.id)
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy
        update_like
    end

    private

    def update_like
        @parent ||= parent
        @parent_model = @parent.model_name.to_s.downcase

        render turbo_stream:
            turbo_stream.replace("#{@parent_model}_#{@parent.id}",
                partial: "likes/#{@parent_model}_likes",
                locals: { parent: @parent })
    end

    def parent
        return Post.find(params[:post_id]) if params[:post_id]

        Comment.find(params[:comment_id]) if params[:comment_id]
    end
end
