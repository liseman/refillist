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

  def push
    shelf = User.find_by_id(7).shelf.find_by_id(params[:sid])
    puts "shelf: #{shelf}"
    json_val = JSON.parse(params[:json]) 
    json_val['datastreams'].each do |data|
      if data['id'] == 'rfid'
        puts "id"
        item = shelf.item.find_by_tag(data['id'])
        if id
          puts "item #{item}"
        end
      end

      if data['id'] == 'weight'
        puts "weight"
        percent = ( data['current_value'] / data['max_value'] ) * 100
        puts "#{percent}% left"
      end

      #puts data['id']
      #puts data['current_value']
      #puts data['at']
      #puts data['max_value']
    end
    render json: { "hi" => "done" }
  end
end
