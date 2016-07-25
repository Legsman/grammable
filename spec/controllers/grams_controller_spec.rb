require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#destroy" do
    it "shouldn't allow users who didn't create the gram to destroy it" do
    p = FactoryGirl.create(:gram)
    user = FactoryGirl.create(:grammer)
    sign_in user
    delete :destroy, id: p.id 
    expect(response).to have_http_status(:forbidden)
  end
    it "should not allow unauthenticated user to destroy a gram" do
      p = FactoryGirl.create(:gram)
      delete :destroy, id: p.id
      expect(response).to redirect_to new_grammer_session_path
  end

    it "should allow user to delete a gram" do
      p = FactoryGirl.create(:gram)
      sign_in p.grammer
      delete :destroy, id: p.id 
      expect(response).to redirect_to root_path
      p = Gram.find_by_id(p.id)
      expect(p).to eq nil
    end

    it "should return a 404 message if we cant find a gram with the specified id" do
      u = FactoryGirl.create(:grammer)
      sign_in u
      delete :destroy, id: "meows"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#update" do
    it "should not let a user who did not create the gram update the gram" do
      p = FactoryGirl.create(:gram)
      user = FactoryGirl.create(:grammer)
      sign_in   user
      patch :update, id: p.id, gram: {message: 'meows'}
      expect(response).to have_http_status(:forbidden)
    end

    it "should not allow unauthenticated user to update a gram" do
      p = FactoryGirl.create(:gram)
      patch :update, id: p.id, gram: {message: 'Changed'}
      expect(response).to redirect_to new_grammer_session_path
  end

    it "should allow user to update the gram" do
      p = FactoryGirl.create(:gram, message: "Initial Value")
      sign_in p.grammer
      patch :update, id: p.id, gram: {message: 'Changed'}
      expect(response).to redirect_to root_path
      p.reload
      expect(p.message).to eq "Changed"
    end

    it "should return a 404 if the gram is not found" do 
      u = FactoryGirl.create(:grammer)
      sign_in u
      patch :update, id: "yoyoyo", gram: {message: 'Changed'}
      expect(response).to have_http_status(:not_found)
    end

    it "should render a new form if gram not valid" do
      p = FactoryGirl.create(:gram, message: "Initial Value")
      sign_in p.grammer
      patch :update, id: p.id, gram: {message: ""}
      expect(response).to have_http_status(:unprocessable_entity)
      p.reload
      expect(p.message).to eq "Initial Value"
    end
  end

  describe "grams#edit" do 
    it "should not let a user who did not create the gram edit the gram" do
      p = FactoryGirl.create(:gram)
      user = FactoryGirl.create(:grammer)
      sign_in   user
      get :edit, id: p.id
      expect(response).to have_http_status(:forbidden)
    end

    it "should not allow unauthenticated user to edit a gram" do
      p = FactoryGirl.create(:gram)
      get :edit, id: p.id
      expect(response).to redirect_to new_grammer_session_path
  end

    it "should succesfully show the edit form if the gram is found" do
      p = FactoryGirl.create(:gram)
      sign_in p.grammer
      get :edit, id: p.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
        u = FactoryGirl.create(:grammer)
        sign_in u
      get :edit, id: 'TATOCAT'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#show action" do
    it "should succesfully show the gram if the page is found" do
    gram = FactoryGirl.create(:gram)
    get :show, id: gram.id
    expect(response).to have_http_status(:success)
  end
    it "should return a 404 error if the gram is not found" do
    get :show, id: 'TATOCAT'
    expect(response).to have_http_status(:not_found)
  end
end

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
      user = FactoryGirl.create(:grammer)
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
      user = FactoryGirl.create(:grammer)
      sign_in user

      post :create, gram: {
        message: 'Hello!',
        picture: fixture_file_upload("/picture.png", 'image/png')
      }
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq('Hello!')
      expect(gram.grammer).to eq(user)
    end

   it "should properly deal with validation errors" do
      user = FactoryGirl.create(:grammer)

      sign_in user

      post :create, gram: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end



  end

end
