class Comment < ActiveRecord::Base
  belongs_to :gram
  belongs_to :grammer
end
