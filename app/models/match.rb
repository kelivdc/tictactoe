# == Schema Information
#
# Table name: matches
#
#  id          :integer          not null, primary key
#  player_a    :string
#  player_b    :string
#  winner_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Match < ApplicationRecord
end
