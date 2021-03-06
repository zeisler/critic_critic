class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :year, presence: true, numericality: true

  has_many :critic_opinions
  has_many :critics, :through => :critic_opinions

  has_many :user_opinions
  has_many :users, :through => :user_opinions

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
