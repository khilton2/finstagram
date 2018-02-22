helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end

get '/' do
  @posts = Post.order(created_at: :desc)
  erb(:index)
end

get '/signup' do
  @user = User.new
  erb(:signup)
end

post '/signup' do
  
  #grab user input values from params
  email       = params[:email]
  avatar_url  = params[:avatar_url]
  username    = params[:username]
  password    = params[:password]
  
  #instantiate a user
  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
  
  if @user.save
    
    #return readable rep of User objet
    redirect to('/login')
  else
    #Display error message
    erb(:signup)
  end
end

get '/login' do
  erb(:login)
end

post '/login' do
  
  # #grab user input values from params
  username    = params[:username]
  password    = params[:password]
  
  # #instantiate a user
  user = User.find_by({  username: username})
  
   #check the user and password
    if user && user.password == password
        #set session
        session[:user_id] = user.id
        #login
        redirect to('/')
    else 
      @error_message = "User or password is incorrect."
      erb(:login)
    end
end

get '/logout' do
  session[:user] = nil
  redirect to('/')
end

get '/posts/new' do
  @post = Post.new
  erb(:"/posts/new")  
end

post '/posts' do
  photo_url = params[:photo_url]
  
  #instantiate new post
  @post = Post.new({ photo_url: photo_url, user_id: current_user.id })
  
  #if @ post validates, save
  if @post.save
    redirect(to('/'))
  else
    erb(:"/posts/new")
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb(:"/posts/show")
end

post '/comments' do 
  # assign values to variables
  text = params[:text]
  post_id = params[:post_id]
  
  #instantiate a comment with those values, and assign it to the current user
  comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id})
  comment.save
  
  #redirect to wherever we came from
  redirect(back)
  
end

post '/likes' do
  post_id = params[:post_id]
  
  like = Like.new({ post_id: post_id, user_id: current_user.id})
  like.save
  
  redirect(back)
  
end

delete '/likes/:id' do
  like = Like.find_by(params[:id])
  like.destroy
  redirect(back)
end
