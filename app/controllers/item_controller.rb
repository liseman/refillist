class ItemController < ApplicationController
  def index
    sid = params[:sid]
#    render json: current_user.shelf.item
# security: restrict to current_user
    render json: Shelf.find_by_id(sid).item
  end

  def create
    # posthack: security -> current_user must own shelf
#    tag = params[:rfid].downcase if params[:rfid]
    item = Item.new( :name => params[:name],
                     :shelf_id => params[:shelfid],
#                     :description => params[:description],
                     :amount => 100
#                     :tag => tag
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
    value = 0
    if params[:iid] == 4
      a = item.amount
      if a < 940
        value = 0
      elsif a > 958
        value = 90
      else
        a -= 940
        a *= 5
        value = a
      end
    else
      value = item.amount
    end
    render json: { 'amount' => value }
  end

  def rfid
    out = `curl -s https://agent.electricimp.com:443/WENqSu+U3q0X`
    out = out.downcase
    done = 0
    if out == 'a1'
      done = 1
    end
    if out == 'b4'
      done = 2
    end
    if out == 'c3'
      done = 3
    end
    if out == 'd4'
      done = 4
    end
    render json: { 'rfid' => done }
  end
end
