class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :movies, :through => :user_opinions
  has_many :user_opinions

  def top_critics
    sql = "select
  id, sum(score) as score
from (
  select critics.id, 1 as score
  from users
  inner join user_opinions
    on users.id = user_opinions.user_id
  inner join movies
    on user_opinions.movie_id = movies.id
  inner join critic_opinions
    on critic_opinions.movie_id = movies.id
    and user_opinions.like = critic_opinions.like
  inner join critics
    on critic_opinions.critic_id = critics.id
  union all
  select critics.id, -1 as score
  from users
  inner join user_opinions
    on users.id = user_opinions.user_id
  inner join movies
    on user_opinions.movie_id = movies.id
  inner join critic_opinions
    on critic_opinions.movie_id = movies.id
    and user_opinions.like != critic_opinions.like
  inner join critics
  on critic_opinions.critic_id = critics.id
  ) as sub
group by id
order by sum(score) desc
limit 5;
"
  puts  "$$$"
    p records_array = ActiveRecord::Base.connection.execute(sql)
    critics_array = {}
    records_array.each do |rec|
      p rec
     critics_array[Critic.find_by_id(rec["id"])] = rec["score"]
    end
    p critics_array
    critics_array
  end
end
