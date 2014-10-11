require 'spec_helper'

describe User do
  
	before{ @user = User.new( name: "Example User", email: "use@rexample.com" )}

	subject{ @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it { should be_valid }

	describe "when name is not present" do
		before{ @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before{ @user.email = " "}
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be inalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |inalid_address|
				@user.email = invalid_address
				it { should_not be_valid }
			end
		end

		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			address.each do |valid_address|
				@user.email = valid_address
				it { should be_valid }
			end
		end
	end
end
