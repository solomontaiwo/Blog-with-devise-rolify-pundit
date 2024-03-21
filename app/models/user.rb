class User < ApplicationRecord
  after_create :assign_default_role

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def assign_default_role
    add_role(:regular_user)
  end

  has_many :articles
  has_many :comments
end
