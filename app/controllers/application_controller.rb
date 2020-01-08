class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end



  #redirects to all recipes, can place index here instead
  get '/' do 
    redirect to '/recipes'
  end 

  #shows all recipes
  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index
  end 

  get '/recipes/new' do 
    erb :new 
  end 

  post '/recipes' do 
    @recipe = params
    @new_recipe = Recipe.create(name: @recipe[:name], ingredients: @recipe[:ingredients], cook_time: @recipe[:cook_time])
    redirect to "/recipes/#{@new_recipe.id}"
  end 

  #shows a specific recipe. This also handles edit redirects 
  get '/recipes/:id' do 

    @recipe = Recipe.find(params[:id])
    erb :show 
  end 

  #edits a recipe
  get '/recipes/:id/edit' do 

    @recipe = Recipe.find_by_id(params[:id])
    erb :edit 
  end 

  #updates recipe, using edit get above 
  patch '/recipes/:id' do 
    new_name = params[:name]
    new_ingredients = params[:ingredients]
    new_cooking_time = params[:cook_time]
    recipe = Recipe.find_by_id(params[:id])
    recipe.update(name: new_name, ingredients: new_ingredients, cook_time: new_cooking_time)
    recipe.save
    redirect to "/recipes/#{recipe.id}"
  end 

  delete '/recipes/:id' do 

    Recipe.delete(params[:id])
    redirect to "/recipes"
  end 

end
