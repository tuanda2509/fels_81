class Word < ActiveRecord::Base
  belongs_to :category

  has_many :lesson, through: :results
  has_many :results
  has_many :answers
  has_many :user_word

  scope :all_words, -> user_id{}
  scope :learned, -> user_id{where "id in (select word_id from results where
    answer_id in (select id from answers where correct = \"t\") and
    lesson_id in (select id from lessons where user_id = #{user_id}))"}
  scope :not_learn, -> user_id{where "id not in (select word_id from results
    where answer_id in (select id from answers where correct = \"t\") and
    lesson_id in (select id from lessons where user_id = #{user_id}))"}
end
