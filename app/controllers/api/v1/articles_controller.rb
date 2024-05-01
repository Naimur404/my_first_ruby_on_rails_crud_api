class Api::V1::ArticlesController < ApplicationController
  def index
    article = Article.all()

    render json: article, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])

    if article
      render json: article, status: 200
      else
        render json: {
          error: "Nothing found"
        }
    end
  end

  def create
    article = Article.new(
       title: arti_parms[:title],
       body: arti_parms[:body],
       author: arti_parms[:author]
    )
    if article.save
      render json: article, status: 200
    else
      render json: {
        error: "something wrong!"
      }
    end
  end

  def update
    article = Article.find_by(id: params[:id])

    if article
      article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: article, status: 200
    else
      render json: {
        error: "Noting to Update"
      }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: {
        message: "Delete Successfully"
      }, status: 200
    else
      render json: {
        error: "Nothing To delete"
      }

    end
  end

  private
  def arti_parms
    params.require(:article).permit([
      :title,
      :body,
      :author])
  end


end
