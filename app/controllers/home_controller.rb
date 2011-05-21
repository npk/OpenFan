class HomeController < ApplicationController
  def index
    @nodes = Node.all
    @hotnodes = Node.all(:include => :topics).sort_by { |p| p.topics.count }
    if(session[:user_id])
      @user = User.find_by_id(session[:user_id])
    else
      @user = User.new
    end
    @users = User.all
    #@topics = Topic.all(:include => :posts, :order => 'topics.created_at DESC,posts.created_at DESC')
    @topics = Topic.all(:include => :posts).sort_by { |p| p.posts.last.nil? ? p.created_at: p.posts.last.created_at}.reverse
    @posts = Post.all
    @title="Home"
    respond_to do |format|
      format.html # index.html.erb
      format.iphone
    end
  end

end
