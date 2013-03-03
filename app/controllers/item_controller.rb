class ItemsController < ApplicationController
  def create
    name = params[:value]
    current_user
    #item = Item.new( :name => name, :_id => current_user.id )
    item.save!
    render json: item
  end

  def update
    id = params[:id]
    # if !id die!
    item = Item.find_by_id(id)
    item.name = params[:value]
    item.save!
  end
end
