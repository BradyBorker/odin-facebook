class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.build(comment_params)

        if @comment.save
            flash[:notice] = "Comment Created"
        else
            flash[:alert] = "Comment not created"
        end

        redirect_to root_path
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
