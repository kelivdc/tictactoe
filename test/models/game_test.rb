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
require "test_helper"

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
