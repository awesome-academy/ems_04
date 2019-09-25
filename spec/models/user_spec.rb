require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    user.save
    expect(user.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "too long" do |field, count|
  it do
    user.save
    expect(user.errors[field].first).to eql I18n.t "errors.messages.too_long",
    count: count
  end
end

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  subject {user}

  describe "should be valid" do
    before {user.save}
    it {is_expected.to be_valid}
  end

  describe "associations" do
    it "has many exams" do
      is_expected.to have_many(:exams).dependent :destroy
    end
    it "has many subjects" do
      is_expected.to have_many(:subjects).class_name(Subject.name)
        .with_foreign_key(:create_by)
    end
  end

  describe "#last_name" do
    it {is_expected.to validate_presence_of :last_name}
    it {is_expected.to validate_length_of(:last_name)
      .is_at_most(Settings.max_name)}

    context "when last name is empty" do
      before{user.last_name = nil}
      it_behaves_like "when empty", :last_name
    end

    context "when last name too long" do
      before{user.last_name= "aaaa" * Settings.max_name}
      it_behaves_like "too long", :last_name, Settings.max_name
    end
  end

  describe "#first_name" do
    it {is_expected.to validate_presence_of(:first_name)
      .with_message(I18n.t("errors.messages.blank"))}
    it {is_expected.to validate_length_of(:first_name)
      .is_at_most(Settings.max_name)}
  end

  describe "#email" do
    context "when valid email" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email)
      .is_at_most(Settings.max_email)}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end

    context "when is email is empty" do
      before {user.email = nil}
      it_behaves_like "when empty", :email
    end

    context "when email too long" do
      before {user.email = "aaaa" * Settings.max_email}
      it {is_expected.not_to be_valid}
    end

    context "when email invalid" do
      it "should be invalid" do
        emails = %w(abc@dc,com invalid.com foo@bar+baz.com)
        emails.each do |invalid_email|
          user.email = invalid_email
          expect(user).not_to be_valid
        end
      end
    end

    context "when email valid" do
      it "should be valid" do
        emails = %w(sangvo@gmail.com info@invalid.com foo@barbaz.com)
        emails.each do |valid_email|
          user.email = valid_email
          expect(user).to be_valid
        end
      end
    end
  end

  describe "should has secure password" do
    it {should have_secure_password}
  end

  describe "scopes" do
    context "order by first name" do
      let(:user1) {FactoryBot.create :user, first_name: "c"}
      let(:user2) {FactoryBot.create :user, first_name: "b"}
      let(:user3) {FactoryBot.create :user, first_name: "a"}
      it "should order by name" do
        expect(User.sort_by_first_name).to eq [user3, user2, user1]
      end
    end
  end

  describe "method private" do
    context "#downcase_email" do
      let(:user1) {FactoryBot.build :user, email: "AbC@GmAil.com"}
      it "should email downcase" do
        expect(user1.email.downcase!).to eq "abc@gmail.com"
      end
    end
  end
end
