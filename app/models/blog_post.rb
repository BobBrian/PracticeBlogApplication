class BlogPost < ApplicationRecord
  #Validation Code
  validates :title, presence: true
  validates :body, presence: true
end
