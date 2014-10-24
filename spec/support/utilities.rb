include ApplicationHelper

def valid_sign_in(user)
	# with: はシンボルではなく、引数のようなものだと考えて良さそうだ。
	fill_in "Email" , with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
end

def sign_in(user, options={})
	if options[:no_capybara]
		#Capybaraを使用していない場合にもサインインする。
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
	else
		visit signin_path unless options[:at_current_page]
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
	end
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-error', text: message )
	end
end