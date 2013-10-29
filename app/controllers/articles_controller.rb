class ArticlesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  # GET /articles
  # GET /articles.json
  def index
    seach_months_article
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    elsif params[:search]
      @articles = Article.search_published(params[:search]).paginate(page: params[:page], per_page: 5)
    else
      @articles = Article.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    end
    #fresh_when(:etag => [@articles, @articles_month], :public => true)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @comment_count = @article.comments.size
    seach_months_article
  end

  # GET /articles/new
  def new
    seach_months_article
    @article = Article.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    seach_months_article
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.user  = current_user
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
        if current_user != nil && current_user.sf_user_id != nil
          Databasedotcom::Chatter::UserProfileFeed.post(@client, current_user.sf_user_id, :text => @article.subject, :url => (request.url+'/'+@article.id.to_s))
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  

end
