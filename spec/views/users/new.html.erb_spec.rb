require "rails_helper"

describe "users/new.html.erb", type: :view do
  let!(:user){User.new}
  subject {rendered}
  before do
    assign :user, user
    render
  end
  it {is_expected.to have_link I18n.t("signup_page.title"), href: root_path}
  it {is_expected.to have_content I18n.t("signup_page.description")}
  describe "form" do
    it "should method post" do
      assert_select 'form[action=?][method=?]', users_path, "post"
    end
    it {is_expected.to have_field "user[last_name]"}
    it {is_expected.to have_field "user[first_name]"}
    it {is_expected.to have_field "user[email]"}
    it {is_expected.to have_field "user[password]"}
    it {is_expected.to have_field "user[password_confirmation]"}
    it {is_expected.to have_selector "form input[@type='submit'][@name='commit']"}
  end
end
