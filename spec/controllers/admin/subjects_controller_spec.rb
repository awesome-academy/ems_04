require "rails_helper"
require "sessions_helper"

RSpec.describe Admin::SubjectsController, type: :controller do
  include SessionsHelper

  describe "Subjects" do
    let(:user){FactoryBot.create :user}
    let(:admin){FactoryBot.create :admin}

    context "before action" do
      it {is_expected.to use_before_action(:logged_in_user) }
      it {is_expected.to use_before_action :check_admin}
      it {is_expected.to use_before_action :load_subject}
    end

    describe "GET #index" do
      context "when user not a admin" do
        before do
          get :index
          store_location
        end
        it{expect(response).to redirect_to login_url(returnUrl: session[:forwarding_url])}
      end
      context "when user login a admin" do
        before do
          log_in admin
          get :index
        end
        it{expect(response).to render_template :index}
      end
    end

    describe "POST #create" do
      before {log_in admin}
      let(:subject){FactoryBot.create :subject, user: admin}
      let(:invalid_subject){FactoryBot.create :invalid_subject, user: admin}

      context "when valid attributes" do
        it do
          post :create, params: {subject: FactoryBot.attributes_for(:subject), format: :js}
          expect(response).to redirect_to admin_subjects_path
        end
      end

      context "when invalid attributes" do
        it "should render js" do
          post :create, params: {
            subject: FactoryBot.attributes_for(:invalid_subject), format: :js}
          expect(response.content_type).to eq("text/javascript")
        end
      end
    end

    describe "PUT #update" do
      before {log_in admin}
      let(:subject){FactoryBot.create :subject, user: admin}
      let(:new_attributes){FactoryBot.attributes_for(:subject, subject_name: "New subject")}
      let(:invalid_params){{subject_name: "", duaration: ""}}

      context "when valid attributes" do
        it do
          put :update, params: {subject: new_attributes , id: subject.id, format: :js}
          subject.reload
          expect(assigns(:subject).attributes["subject_name"]).to match(new_attributes[:subject_name])
        end
      end

      context "when invalid attributes" do
        it do
          put :update, params: {subject: invalid_params, id: subject.id, format: :js}
          expect(response.content_type).to eq("text/javascript")
        end
      end
    end

    describe "DELETE #destroy" do
      before {log_in admin}
      let(:subject){FactoryBot.create :subject, user: admin}

      context "when delete success" do
        it do
          delete :destroy, params: {id: subject.id}
          expect(controller).to set_flash[:success]
        end
      end
    end
  end
end
