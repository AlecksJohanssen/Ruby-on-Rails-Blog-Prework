class CommentsController < ApplicationController
	before_filter :require_login
	def create
  @comment = Comment.new(comment_params)
  @comment.article_id = params[:article_id]
  @comment.save

  redirect_to article_path(@comment.article)
end
def destroy
    @article = Article.find(params[:article_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to @article }
            format.js
        end
    end

def comment_params
  params.require(:comment).permit(:user_name, :body)
end
    
end