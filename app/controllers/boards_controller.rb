class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @list_of_boards = Board.all.order(created_at: :desc)
    render({ template: "boards/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_board = Board.find_by(id: the_id)

    @matching_posts = Post.where(board_id: @the_board.id)
    @active_posts = @matching_posts.where(expires_on: (Time.current...)).order(:expires_on)
    @expired_posts = @matching_posts.where.not(expires_on: (Time.current...)).order(expires_on: :desc)

    render({ template: "boards/show" })
  end

  def create
    the_board = Board.new
    the_board.name = params.fetch("query_name")
    the_board.user_id = current_user.id  # Associate the board with the signed-in user

    if the_board.valid?
      the_board.save
      redirect_to("/boards/#{the_board.id}", { notice: "Board created successfully." })
    else
      redirect_to("/boards", { alert: the_board.errors.full_messages.to_sentence })
    end
  end

  def update
    the_board = Board.find(params.fetch("path_id"))
    the_board.name = params.fetch("query_name")

    if the_board.valid?
      the_board.save
      redirect_to("/boards/#{the_board.id}", notice: "Board updated successfully.")
    else
      redirect_to("/boards/#{the_board.id}", alert: the_board.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_board = Board.find(params.fetch("path_id"))
    the_board.destroy
    redirect_to("/boards", notice: "Board deleted successfully.")
  end
end
