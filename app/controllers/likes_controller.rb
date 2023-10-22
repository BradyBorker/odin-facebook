class LikesController < ApplicationController
    def create
        @parent = parent
        @like = @parent.likes.build(user_id: current_user.id)
        @like.save

        update_like
    end

    def destroy
        @parent = parent
        @like = @parent.likes.find(params[:id])
        @like.destroy

        update_like
    end

    private

    def parent
        return Post.find(params[:post_id]) if params[:post_id]

        Comment.find(params[:comment_id]) if params[:comment_id]
    end

    def update_like
        @parent ||= parent
        @parent_model = @parent.model_name.to_s.downcase

        render turbo_stream:
            turbo_stream.replace("#{@parent_model}_like_#{@parent.id}",
                partial: "likes/#{@parent_model}_likes",
                locals: { parent: @parent })
    end
end
