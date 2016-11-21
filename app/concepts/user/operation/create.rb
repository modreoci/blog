require 'reform/form/dry'

class User < ActiveRecord::Base
  class Create < Trailblazer::Operation
    policy Session::Policy, :create?

    include Model

    model User, :create

    contract Contract::Create do
      feature Reform::Form::Dry
      property :password, virtual: true
      property :confirm_password, virtual: true
      
      
      
      validation do
        configure do
          option :form
          config.messages_file = 'config/error_messages.yml'

          def must_be_equal?
            return form.password == form.confirm_password
          end
        end
        
        required(:password).filled
        required(:confirm_password).filled(:must_be_equal?)

      end
    end

    def process(params)
      validate(params) do
        update!
        contract.save
      end
    end

  private
    def update!
      auth = Tyrant::Authenticatable.new(contract.model)
      auth.digest!(contract.password) # contract.auth_meta_data.password_digest = ..
      auth.confirmed!
      auth.sync
    end

  end
end