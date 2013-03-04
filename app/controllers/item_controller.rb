class ItemController < ApplicationController
  def index
    sid = params[:sid]
#    render json: current_user.shelf.item
# security: restrict to current_user
    render json: Shelf.find_by_id(sid).item
  end

  def create
    # posthack: security -> current_user must own shelf
    tag = params[:rfid].downcase
    item = Item.new( :name => params[:name],
                     :shelf_id => params[:shelfid],
                     :description => params[:description],
                     :amount => 100,
                     :tag => tag
                   )
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

  def amt
    item = Item.find_by_id(params[:iid])
    render json: { 'amount' => item.amount }
  end
end
