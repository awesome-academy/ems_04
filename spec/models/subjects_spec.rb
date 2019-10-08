require 'rails_helper'

RSpec.describe Subject, type: :model do

  let(:subject) {FactoryBot.create :subject}

  describe "should be valid" do
    before{subject.save}
    it {is_expected.to be_valid}
  end

  describe "associations" do
    it {is_expected.to have_many(:exams).dependent :destroy}
    it {is_expected.to have_many(:questions).dependent :destroy}
    it {is_expected.to belong_to(:user).class_name(User.name).
      with_foreign_key(:create_by)}
  end

  describe "validations" do
    it {is_expected.to validate_presence_of(:subject_name).
      with_message(I18n.t "errors.messages.blank")}
    it {is_expected.to validate_length_of(:subject_name).
      is_at_most(Settings.max_subject_name)}
    it {is_expected.to validate_presence_of(:duaration)}
    it {is_expected.to validate_presence_of(:total_score)}
    it {is_expected.to validate_presence_of(:limit_questions)}
  end
end
