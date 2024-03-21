class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def create?
    user.present?  # Any authenticated user can create an article
  end

  def update?
    user.has_role?(:admin) || article.user == user  # Only admin or the article owner can update
  end

  def edit?
    user.present? && article.user == user || user.has_role?(:admin)
  end

  def destroy?
    user.has_role?(:admin) || article.user == user  # Only admin or the article owner can delete
  end
end
