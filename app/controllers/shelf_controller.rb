class ShelfController < ApplicationController
  def index
    render json: current_user.shelf.all
  end

  def create
    name = params[:name]
    shelf = Shelf.new( :name => name, :user_id => current_user.id )
    shelf.save!
    render json: shelf
  end

  def update
    id = params[:id]
    # if !id die!
    shelf = Shelf.find_by_id(id)
    shelf.name = params[:value]
    shelf.save!
    render json: shelf
  end
end
