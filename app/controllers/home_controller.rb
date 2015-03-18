class HomeController < ApplicationController
  def index
    redirect_to user_path(current_user) if user_signed_in?
    @all_coach = []
    #CoachDetail.all.each do |each_coach|
    #  @all_coach.push(each_coach.name)
    #end
  end
end
