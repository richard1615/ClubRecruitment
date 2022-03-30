class User < ApplicationRecord
  has_secure_password

  has_many :role_assignment, inverse_of: :user
  has_many :roles, through: :role_assignment
  belongs_to :club, optional: true
  has_one :application, dependent: :destroy
  belongs_to :branch, optional: true

  accepts_nested_attributes_for :role_assignment

  validates :email, presence: true, uniqueness: true

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def admin?
    has_role?(:admin)
  end

  def assign_role(role_id)
    role_assignment.create(role_id: role_id)
  end
end
