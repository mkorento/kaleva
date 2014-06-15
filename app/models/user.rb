class User < ActiveRecord::Base
  has_secure_password
  has_many :enrollments
  has_many :events, through: :enrollments

  validates :username, uniqueness: true, length: { minimum: 3 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :birth_date, presence: true
  validates :address, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 },
                       format: { with: /.*(\d.*[A-Z]|[A-Z].*\d).*/}
end
