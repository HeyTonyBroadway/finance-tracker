class UsersController < ApplicationController
	def my_portfolio
		@user_stocks = current_user.stocks
		@user = current_user
	end

	def my_friends
		@friendships = current_user.friends
	end

	def search
		@users = User.search(params[:search_param])

		if @users
			@users = current_user.except_current_user(@users) #we don't want ourselves to show up on search
			render partial: "friends/lookup"
		else
			render status: :not_found, nothing: true #our AJAX error handling will handle this
		end
	end

	def add_friend
		@friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id) #we are building a relationship so we use build method

		if current_user.save
			redirect_to my_friends_path, notice: "Friend was successfully added"
		else
			redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend"
		end
	end
end