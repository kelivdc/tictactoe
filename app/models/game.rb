# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  player_a   :string
#  player_b   :string
#  winner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Game < ApplicationRecord
    validates :player_a, presence: true
    validates :player_b, presence: true
end
