require 'sequel'
require 'grape'

module Rest
    class API < Grape::API
        format :json

        resource "users" do
            desc "Sign up as a new user and get an API key"
            params do
                requires :name, type: String, desc: "user' name"
                requires :email, type: String, desc: "user' email"
                requires :password, type: String, desc: "user' password"
                requires :password_confirmation, type: String, desc: "user' password. again"
            end
            post 'sign_up' do
                user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
                { success: true, id: user.id, api_key: user.api_key }
            end

            get do
                { success: true, users: User.all }
            end
        end
    end
end
