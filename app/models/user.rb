class User < ActiveRecord::Base
  has_secure_password
  validates :password, :password_confirmation, :email, :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 5 }

  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip()
    user = User.find_by 'email ILIKE ?', stripped_email
    loggedInUser = user.authenticate(password)
    loggedInUser ? loggedInUser : nil
  end

end
