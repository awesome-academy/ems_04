require "rails_helper"

RSpec.describe Exam, type: :model do
  let(:exam) {FactoryBot.create :exam}
  subject{exam}

  it "should be valid" do
    is_expected.to be_valid
  end

  describe "associations" do
    it "has many user_answer_exams" do
      is_expected.to have_many :user_answer_exams
    end
    it "should be long to subject" do
      is_expected.to belong_to :subject
    end
    it "should be long to user" do
      is_expected.to belong_to :user
    end
    it "should has many and belong to questions" do
      is_expected.to have_and_belong_to_many(:questions)
    end
  end

  describe "scopes" do
    let(:exam_1) {FactoryBot.create :exam}
    it "should order by create at" do
      expect(Exam.exam_lastest).to eq [exam_1, exam]
    end
  end
end
