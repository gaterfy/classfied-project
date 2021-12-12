# frozen_string_literal: true

# user model
class User < ApplicationRecord
  has_secure_password

  has_many :classfieds

  validates_presence_of :fullname, :username, :password_digest, presence: true
  validates_uniqueness_of :username
end
