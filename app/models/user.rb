class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :user_opinions
end
