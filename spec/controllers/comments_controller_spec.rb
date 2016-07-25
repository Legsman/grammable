require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do 
    it "should allow users to create comments on grams" do
      p = FactoryGirl.create(:gram)
      u = FactoryGirl.create(:grammer)
      sign_in u
      post :create, gram_id: p.id, comment: {message: 'hell yeah'}
      expect(response).to redirect_to root_path
      expect(p.comments.length).to eq 1
      expect(p.comments.first.message).to eq 'hell yeah'
    end

    it "should require the user to be logged in to comment a gram" do
      p = FactoryGirl.create(:gram)
      post :create, gram_id: p.id, comment: {message: 'meows'}
      expect(response).to redirect_to new_grammer_session_path
    end

    it "should return a http status of not found if the gram isnt found" do
      u = FactoryGirl.create(:grammer)
      sign_in u
      post :create, gram_id: "YOLO", comment: {message: 'meows'}
      expect(response).to have_http_status :not_found
    end

  end

end
