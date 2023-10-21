class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            flash[:notice] = 'Comment Created'
            render turbo_stream:
                turbo_stream.append("comment-container_#{@post.id}".to_sym,
                partial: 'comments/comment',
                locals: { comment: @comment })
        else
            flash[:alert] = 'Comment not created'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
