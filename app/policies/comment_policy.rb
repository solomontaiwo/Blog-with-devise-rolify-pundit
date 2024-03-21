class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.present? # Any authenticated user can create a comment
  end

  def destroy?
    user.has_role?(:admin) || comment.user == user  # Only admin or the article owner can delete comments
  end
end
