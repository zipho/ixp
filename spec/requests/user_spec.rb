# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'User onboarding' do
    let(:user) { build(:user) }

    context 'GET /start' do
      it 'should respond with a 200' do
        get start_path
        expect(response).to have_http_status(:ok)
      end
    end
    context 'SHOW /user' do
      let(:user) { create(:user) }
      let(:http_request) { get done_path(user) }
      it 'should be successful' do
        http_request
        expect(response).to have_http_status(200)
      end
    end

    context 'EDIT /user' do
      let(:user) { create(:user) }
      let(:http_request) { get next_path(user) }
      it 'should be successful' do
        http_request
        expect(response).to have_http_status(200)
      end
    end

    context 'step 1' do
      context 'POST /step1' do
        let(:http_request) { post step1_path, params: { user: params } }
        let(:my_user) { build(:user) }

        context 'with valid user input' do
          let(:user_details) { user.attributes }
          let(:params) { user_details.update({ password: '!1Password', password_confirmation: '!1Password' }) }
          it 'should create a new user' do
            http_request
            user1 = User.first
            expect(params['first_name']).to eq(user1.first_name)
          end

          let(:params) { my_user.attributes.update({ password: '!1Password', password_confirmation: '!1Password' }) }
          it 'should redirect to /next' do
            http_request
            myuser = User.first
            expect(response).to redirect_to(next_path(myuser))
          end
        end

        context 'with invalid user input' do
          let(:params) { {} }
          it 'should not create a new user' do
            http_request
            expect(response).to render_template(:new)
          end
        end
      end
    end

    context 'step 2' do
      context 'UPDATE /step2' do
        let!(:new_user) { create(:user) }
        let(:http_request) { patch step2_path(new_user), params: { user: params } }
        context 'update with valid details' do
          let(:params) { { gender: 1, birthday: '1980/01/20', signup_step: 2 } }
          it 'should update the record' do
            http_request
            expect(new_user.reload.gender).to eq(1)
          end

          it 'should redirect to /done_path' do
            http_request
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(done_path)
          end
        end

        context 'update with valid details' do
          let(:params) { { gender: 1, birthday: '1980/01/20', signup_step: 2 } }
          it 'should update the record' do
            http_request
            expect(new_user.reload.gender).to eq(1)
          end

          it 'should redirect to /done_path' do
            http_request
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(done_path)
          end
        end
        context 'update with invalid details' do
          let(:params) { { gender: 1, signup_step: 2 } }
          it 'should update the record' do
            http_request
            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
