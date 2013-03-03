class ItemController < ApplicationController
  def index
    sid = params[:sid]
    render json: current_user.shelf(sid).items.all
  end

  def create
    puts params
    name = params[:value]
    # posthack: security -> current_user must own shelf
    #item = Item.new( :name => name, :_id => current_user.id )
    #item.save!
    render json: params
  end

  def update
    id = params[:id]
    # if !id die!
    item = Item.find_by_id(id)
    item.name = params[:value]
    item.save!
  end
end
