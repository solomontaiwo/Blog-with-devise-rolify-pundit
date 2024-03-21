# app/helpers/application_helper.rb
module ApplicationHelper
  def current_user_role
    if user_signed_in?
      if current_user.has_role?(:admin)
        "Admin"
      else
        "Regular User"
      end
    end
  end
end
