require "rails_helper"

describe "admin/subjects/index.html.erb", type: :view do
  let(:list_subjects){FactoryBot.create_list(:subject, 10)}
  let(:subject){Subject.new}

  before do
    view.lookup_context.view_paths.push 'app/views/admin'
    allow(view).to receive_messages(will_paginate: nil)
    assign(:subjects, list_subjects)
    assign(:subject, subject)
    render
  end

  describe "form new subject" do
    it {expect(rendered).to have_field "subject[subject_name]"}
    it {expect(rendered).to have_field "subject[duaration]"}
    it {expect(rendered).to have_field "subject[limit_questions]"}
    it {expect(rendered).to have_field "subject[total_score]"}
    it {expect(rendered).to have_button I18n.t("app_button.add_new")}
  end

  describe "list subject" do
    it {expect(rendered).to render_template "_subject"}
    it {expect(rendered).to render_template "_form"}
    it {expect(rendered).to render_template "_modal_form"}
  end
end
