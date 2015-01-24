require 'spec_helper'

describe User do
	let(:valid_attributes) {
		{
			first_name: "Sebastian",
			last_name: "Velandia",
			email: "sebas.velandia@grupo.ly",
			password: "elarquero27",
			password_confirmation: "elarquero27"
		}
	}

	context "relationships" do
		it { should have_many(:todo_lists) }
	end

	context "Validations" do
		let(:user) { User.new(valid_attributes) }

		before do
			User.create(valid_attributes)
		end

		it "Requires an email" do
			expect(user).to validate_presence_of(:email)
		end

		it "Requires a unique email" do
			expect(user).to validate_uniqueness_of(:email)
		end

		it "Requires a unique email (case insensitive)" do
			user.email = "SEBAS.VELANDIA@GRUPO.LY"
			expect(user).to validate_uniqueness_of(:email)
		end

		it "Requires the email address to look like an email" do
			user.email = "sebas"
			expect(user).to_not be_valid
		end

	end

	describe "#downcase_email" do
		it "Makes the email lower case" do
			user = User.new(valid_attributes.merge(email: "SEBAS.VELANDIA@GRUPO.LY"))
			expect{ user.downcase_email }.to change{ user.email }.
			from("SEBAS.VELANDIA@GRUPO.LY").
			to("sebas.velandia@grupo.ly")
		end

		it "Downcases an email before saving" do
			user = User.new(valid_attributes)
			user.email = "SEBAS.VELANDIA@GRUPO.LY"
			expect(user.save).to be_truthy
			expect(user.email).to eq("sebas.velandia@grupo.ly")
		end
	end

	describe "#generate_password_reset_token!" do
		let(:user){ create(:user) }

		it "changes the password_reset_token attribute" do
			expect{ user.generate_password_reset_token! }.to change{ user.password_reset_token }
		end

		it "calls SecureRandom.urlsafe_base64 to generate the password_reset_token" do
			expect(SecureRandom).to receive(:urlsafe_base64)
			user.generate_password_reset_token!
		end
	end

	describe "#create_default_lists" do
		let(:user) { create(:user) }
		it "creates a todo list" do
			expect{ user.create_default_lists }.to  change{ user.todo_lists.size }.by(1)
		end

		it "creates only ONE todo list" do
			expect{ user.create_default_lists }.to  change{ user.todo_lists.size }.by(1)
			expect{ user.create_default_lists }.to  change{ user.todo_lists.size }.by(0)
		end

		it "creates todo items" do
			expect { user.create_default_lists }.to change{ TodoItem.count }.by(7)
		end	

		it "does not create todo items twice" do
			expect { user.create_default_lists }.to change{ TodoItem.count }.by(7)
			expect { user.create_default_lists }.to change{ TodoItem.count }.by(0)
		end
	end
end