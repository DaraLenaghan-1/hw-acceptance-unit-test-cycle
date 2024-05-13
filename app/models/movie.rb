class Movie < ActiveRecord::Base
  def self.find_by_director(director)
    where(director: director)
  end
end
