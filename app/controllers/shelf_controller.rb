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

  def push_weight
    shelf = User.find_by_id(7).shelf.find_by_id(params[:sid])
    val = JSON.parse(param[:json]).downcase
  end

  def push_rfid
    puts "sdfsfsdfsfdsfasfasfsafsafasdsa"
    #shelf = User.find_by_id(7).shelf.find_by_id(params[:sid])
    val = params[:json].downcase
    #item = shelf.item.find_by_tag(val)
#    item = Item.find_by_tag(val)
    item = Item.find_by_id(5)
    out = `curl -s https://agent.electricimp.com/5ip8Tl09cliT`
    out = out.to_i
    puts "out #{out}"
#    percent = ( out / 855.0 ) * 100.0
    moo = 855.0 - 700.0
    foo = out - 700.0
    puts foo
    percent = ( moo / foo  ) * 100.0
    puts percent
#full whiskey 740
    if percent > 100
      percent = 100
    end
    if percent < 0
      percent = 0
    end
    puts "percent #{percent}"
    item.amount = out
    item.save!

    render json: { "amount" => "done" }
  end

  def push
    shelf = User.find_by_id(7).shelf.find_by_id(params[:sid])
    puts "shelf: #{shelf}"
    json_val = JSON.parse(params[:json]) 
    json_val['datastreams'].each do |data|
      item = nil
      if data['id'] == 'rfid'
        puts "id"
        val = data['current_value'].downcase
        item = shelf.item.find_by_tag(val)
        if item
          puts "item #{item}"
        end
      end

      if data['id'] == 'weight' and item != nil
        puts "weight"
        percent = ( data['current_value'].to_i / data['max_value'].to_i ) * 100
        puts "#{percent}% left"
        item.amount = percent
        item.save!
      end

      #puts data['id']
      #puts data['current_value']
      #puts data['at']
      #puts data['max_value']
    end
    render json: { "amount" => "done" }
  end
end
