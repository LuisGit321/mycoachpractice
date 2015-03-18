class Users::StudentsController < UsersController

  skip_before_filter :authenticate_user!

  def provider_confirmation
     if @student = User.confirm_by_provider_token(params[:provider_confirmation_token])
       flash["notice"] = "Student is confirmed!"
     else
       flash["error"] = "Invalid token!"
     end
     redirect_to root_path
  end
end
