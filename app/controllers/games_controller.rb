class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
    session[:board] = ["","","","","","","","",""]
    session[:x] = @game.player_a
    session[:o] = @game.player_b
    session[:total_click] = 0
    max_cell = 9
    marks = ["O","X"]
    session[:marks] = marks
    respond_to do |format|
      format.html # Render HTML view
      format.json { render json: @game }
    end
  end

  # GET /games/new
  def new
    @game = Game.new   
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)
    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def click
    session[:current_player] = session[:marks].rotate![0]
    player = session[:current_player]
    cell = params[:cell].to_i - 1 # Because array start from 0 (zero)
    board = session[:board]
    board[cell] = player    
    winner = player_win(player)
    body_render = "<div class=""cell"">#{player}</div>
        <script>$(document).ready(function() {"    
    if player == "X"      
          body_render += "
            $('#player_a').removeClass('turn');
            $('#player_b').addClass('turn');"         
    else
      body_render += "
        $('#player_b').removeClass('turn');
        $('#player_a').addClass('turn');"
    end
  if winner
    body_render += "$('#main').attr('hx-disable','');
                  $('#winner').html('<strong>#{winner}</strong>');
                  $('#player_a').removeClass('turn');
                  $('#player_b').removeClass('turn');
                  "
  else
    session[:total_click] += 1
    if session[:total_click] >= 9
      body_render += "
          $('#winner').html('<strong>Draw</strong>');
          $('#player_a').removeClass('turn');
          $('#player_b').removeClass('turn');
        "
    end
  end
  body_render += " });</script>"
    render inline: body_render
  end

  def player_win(player)
    winner = [ 
      [0,1,2], # top_row 
      [3,4,5], # middle_row 
      [6,7,8], # bottom_row 
      [0,3,6], # left_column 
      [1,4,7], # center_column 
      [2,5,8], # right_column 
      [0,4,8], # left_diagonal 
      [6,4,2] # right_diagonal 
    ]
    board = session[:board]
    winner.each do |cells|
        win = false
        total = 0 #  total same symbol
       cells.each do |c|
        total += 1 if board[c] == player 
        if total >= 3
          if player == "X"
            return session[:x]
          else
            return session[:o]
          end
        end
       end
    end    
    return nil
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def game_start
    players = [@game.player_a, @game.player_b]
    session[:players] = players
    session[:current_player] = @game.player_a
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:player_a, :player_b, :winner)
    end
end
