class Article < ApplicationRecord
  validates :login, :presence => true
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :content, :presence => true
end
