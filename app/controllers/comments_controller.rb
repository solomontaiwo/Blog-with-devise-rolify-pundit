class CommentsController < ApplicationController
  include Pundit::Authorization

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment

    puts "COMMENT COMMENT COMMENT: #{@comment.inspect}"

    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      errors = @comment.errors.full_messages.join(', ')
      puts "##### ERRORS #####:"
      puts errors
      flash[:alert] = errors
      redirect_to @article
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment

    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
