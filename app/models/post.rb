# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  expires_on :date
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#
class Post < ApplicationRecord
  belongs_to :board
  belongs_to :user
  validates :title, :body, :expires_on, presence: true
end
