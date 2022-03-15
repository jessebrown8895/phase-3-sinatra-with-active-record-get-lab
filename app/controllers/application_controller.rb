class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/bakeries' do 
   #get all the bakeries from the Database 
   #send them back as a JSON array
   bakery = Bakery.all
   bakery.to_json
  end 

  get '/bakeries/:id' do 
   
    bakery = Bakery.find_by_id(params[:id])
    bakery.to_json(only: [:name], include: {
      baked_goods: {only: [:name, :price]}
    })
  end

  get '/baked_goods/by_price' do 

    baked_goods = BakedGood.all.order(price: :desc)
    baked_goods.to_json(only: [:name, :price])
  end 

  get '/baked_goods/most_expensive' do 
    baked_goods = BakedGood.order(price: :desc).first
    baked_goods.to_json
  end 
end
