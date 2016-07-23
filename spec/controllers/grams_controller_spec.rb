require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
     it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end  
  end

  describe "grams#new action" do 
    it "should require users to be logged in" do
        get :new
        expect(response).to redirect_to new_grammer_session_path
      end
    it "should succesfully show the new form" do
      user = Grammer.create(
        email: 'fake@gmail.com',
        password: 'secretPassword',
        password_confirmation: 'secretPassword')
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do 
    it "should require users to be logged in" do
        post :create, {message: "Hello!"}
        expect(response).to redirect_to new_grammer_session_path
      end
    it "should succesfully create a new gram in our db" do
      user = Grammer.create(
        email: 'fake@gmail.com',
        password: 'secretPassword',
        password_confirmation: 'secretPassword')
      sign_in user

      post :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq('Hello!')
      expect(gram.grammer).to eq(user)
    end

   it "should properly deal with validation errors" do
      user = Grammer.create(
        email: 'fake@gmail.com',
        password: 'secretPassword',
        password_confirmation: 'secretPassword')
      sign_in user

      post :create, gram: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end


  end

end
