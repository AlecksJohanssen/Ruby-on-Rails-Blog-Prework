class User < ActiveRecord::Base
  authenticates_with_sorcery!
validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates :email, :presence => true, :uniqueness => true, :email_format => true
    validates_confirmation_of :password, message: "should match confirmation", if: :password
end
