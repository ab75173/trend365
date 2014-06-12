class WelcomeController < ApplicationController
  def index
    if current_user
    @favorites = Favorite.where(user_id: current_user.id)
    end
  end
end
