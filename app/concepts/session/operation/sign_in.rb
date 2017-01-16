class Session::SignIn < Trailblazer::Operation
  step Contract::Build(constant: Session::Contract::SignIn)
  step Contract::Validate()
  step :model!    

  def model!(options, *)
    result["current_user"] = User.find_by(email: params[:email])
  end 
end
