class CommentsController < ApplicationController
  before_filter :require_user

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment])
    @comment.user = current_user
    @comment.save
    #Databasedotcom::Chatter::UserProfileFeed.post(@client, current_user.sf_user_id, :text => @comment.body, :url => request.referer)
    respond_to do |format|
      format.html { redirect_to article_path(@article)}
      format.js
    end
    #CommentMailer.comment_email(@article).deliver
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    render :create
  end
end
