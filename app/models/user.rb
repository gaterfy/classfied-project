# frozen_string_literal: true

# user model
class User < ApplicationRecord
  has_secure_password

  has_many :classfieds

  validates_presence_of :firstname, :lastname, :username, :password_digest, presence: true
  validates_uniqueness_of :username

  def fullname
    "#{firstname} #{lastname}"
  end

  def self.from_token_request(request)
    username = request.params['auth'] && request.params['auth']['username']
    find_by(username: username)
  end
end
