class LikesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    if !current_user
      flash[:notice] = 'Please login first!'
    else
      if current_user.has_like? @article
        flash[:notice] = 'You have liked it!'
      else
        @like = @article.likes.build(params[:like])
        @like.article = @article
        @like.user = current_user
        @like.save
      end
    end
    render :toggle
  end

  def destroy
    @like = Like.find(params[:id]).destroy
    @article = @like.article
    render :toggle
  end
end