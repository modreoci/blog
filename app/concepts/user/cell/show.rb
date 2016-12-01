module User::Cell
  class Show < Trailblazer::Cell 
    property :email
    property :content

    def edit
      if tyrant.current_user.email.to_s == model.email or tyrant.current_user.email == "admin@email.com"
        link_to "Edit", edit_user_path(model)
      end
    end

    def delete
      if tyrant.current_user.email.to_s == model.email or tyrant.current_user.email == "admin@email.com"
        link_to "Delete", user_path(model.id), method: :delete, data: {confirm: 'Are you sure?'}
      end
    end

    def change_password
      if tyrant.current_user.email.to_s == model.email or tyrant.current_user.email == "admin@email.com"
        link_to "Change Password", get_new_password_users_path
      end
    end
  end
end