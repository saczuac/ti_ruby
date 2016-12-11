require "rails_helper"

RSpec.describe TasksController, :type => :controller do

  describe "POST #new" do
    it "should raise parameter missing because there is no data given" do
      get :new
      expect {
        post :create, {:task => nil}
      }.to raise_error(ActionController::ParameterMissing)
    end
  end

end