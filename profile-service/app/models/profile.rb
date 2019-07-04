class Profile < ApplicationRecord
  validates :login, :presence => true, :uniqueness => true
  validates :user_id, :presence => true, :uniqueness => true
  validates :name, :presence => true, :length => { :in => 1..20 }
  validates :surname, :length => { :in => 1..30 }
  validates :email, :length => { :in => 1..30 }
  validates :bio, :length => { :in => 1..2500 }
end
