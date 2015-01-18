require 'spec_helper'

RSpec.describe PasswordResetsController, :type => :controller do

	describe "GET new" do
		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end
	end

	describe "POST create" do
		context "with a valid user and email" do
			let(:user){ create(:user) }

			it "finds the user" do
				expect(User).to receive(:find_by).with(email: user.email).and_return(user)
				post :create, email: user.email
			end

			it "generates a new password_reset_token" do
				expect{ post :create, email: user.email; user.reload }.to change{ user.password_reset_token }
			end

			it "sends a password reset email" do
				expect{ post :create, email: user.email; user.reload }.to change( ActionMailer::Base.deliveries, :size )
			end

			it "sets the flash message" do
				post :create, email: user.email
				expect(flash[:success]).to have_content("Further instructions were sent to your email")
			end
		end

		context "with an invalid user and email" do
			it "renders new page" do
				post :create, email: "not@found.com"
				expect(response).to render_template('new')
			end

			it "sets the flash message" do
				post :create, email: "not@found.com"
				expect(flash[:error]).to have_content("There is not an account with that email")
			end
		end
	end

	describe "GET edit" do
		context "with a valid password_reset_token" do
			let(:user) { create(:user) }
			before { user.generate_password_reset_token! }

			it "renders the edit template" do
				get :edit, id: user.password_reset_token
				expect(response).to render_template('edit')
			end

			it "assigns a @user" do
				get :edit, id: user.password_reset_token
				expect(assigns(:user)).to 	eq(user)
			end
		end

		context "with a invalid password_reset_token" do
			it "renders 404 not found page" do
				get :edit, id: 'not-found'
				expect(response.status).to eq(404)
			end
		end
	end

	describe "PATCH update" do
		context "with no token found" do
			it "renders the edit page" do
				patch :update, id: 'not-found', user: { password: "elarquero", password_confirmation: "elarquero" }
				expect(response).to render_template('edit')	
			end

			it "sets the flash message" do
				patch :update, id: 'not-found', user: { password: "elarquero", password_confirmation: "elarquero" }
				expect(flash[:notice]).to match(/not found/)
			end
		end

		context "with a valid token" do
			let(:user) { create(:user) }
			before { user.generate_password_reset_token! }

			it "updates the user's password" do
				digest = user.password_digest
				patch :update, id: user.password_reset_token, user: { password: "newpassword", password_confirmation: "newpassword" }
				user.reload
				expect(user.password_digest).to_not eq(digest)
			end

			it "clears the password_reset_token" do
				patch :update, id: user.password_reset_token, user: { password: "newpassword", password_confirmation: "newpassword" }
				user.reload
				expect(user.password_reset_token).to be_blank
			end

			it "sets the session[:user_id] to the user's id" do
				patch :update, id: user.password_reset_token, user: { password: "newpassword", password_confirmation: "newpassword" }
				user.reload
				expect(session[:user_id]).to eq(user.id)
			end

			it "sets the flash success message" do
				patch :update, id: user.password_reset_token, user: { password: "newpassword", password_confirmation: "newpassword" }
				user.reload
				expect(flash[:success]).to match(/successfully/)
			end

			it "redirects to the todo_lists_path" do
				patch :update, id: user.password_reset_token, user: { password: "newpassword", password_confirmation: "newpassword" }
				user.reload
				expect(response).to redirect_to(todo_lists_path)
			end
		end
	end
end
