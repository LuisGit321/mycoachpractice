module Navigation
  def path_to(page_name)
    case page_name
    when "my profiles"
      user_path(@document)
    when "sign in"
      new_user_session_path
    when "sign up"
      new_user_registration_path
    when "home"
      "/"
    end
  end
end

World(Navigation)
