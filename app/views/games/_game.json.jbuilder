json.extract! game, :id, :player_a, :player_b, :winner, :created_at, :updated_at
json.url game_url(game, format: :json)
