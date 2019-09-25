require "rails_helper"

RSpec.describe Question, type: :model do
  describe "associations" do
    it {is_expected.to have_many(:answers).dependent :destroy}
    it {is_expected.to have_many :user_answer_exams}
    it {is_expected.to belong_to(:user).with_foreign_key(:create_by)}
    it {is_expected.to belong_to(:subject)}
    it {is_expected.to have_and_belong_to_many(:exams)}
  end
  describe "accept nested attribute" do
    it {is_expected.to accept_nested_attributes_for(:answers)
      .allow_destroy true}
  end
  describe "validations" do
    it {is_expected.to validate_presence_of(:question_content)}
  end

  describe "delegate" do
    it {is_expected.to delegate_method(:subject_name).to(:subject)}
  end
end
