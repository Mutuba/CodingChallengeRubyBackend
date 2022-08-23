class Post < ApplicationRecord
   has_many :comments, as: :commented_on
end
