class User < ApplicationRecord
  has_secure_password

  has_many :role_assignment
  has_many :roles, through: :role_assignment
  belongs_to :club

  accepts_nested_attributes_for :role_assignment

  validates :email, presence: true, uniqueness: true

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
