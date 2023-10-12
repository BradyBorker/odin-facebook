class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            flash[:notice] = "Comment Created"
        else
            flash[:alert] = "Comment not created"
        end

        render turbo_stream: turbo_stream.append("comment_#{@comment.id}", partial: 'comment/comment',
            locals: { post: @comment })
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
