require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    describe "GET #index" do
    context "when user is a manager" do
      it "returns a successful response" do
        user = create(:manager)
        sign_in(user)
        projects = create_list(:project, 3)

        get :index, format: :json       
        test_names = projects.map(&:name)
        json_response = JSON.parse(response.body)        
                    
        project_names = json_response.map { |project| project["name"] }
        expect(project_names).to match_array(test_names)        
      end
    end
    context "when user is a developer" do
      it "returns a successful response without projects" do
        user = create(:user)
        sign_in(user)
        projects = create_list(:project, 3)
        
        get :index, format: :json    
              
        expect(JSON.parse(response.body)).to be_empty
      end
    end        
  
end
describe "GET #edit" do
context "when user is a manager" do
  it "returns a successful response" do
    user = create(:manager)
    sign_in(user)
    project = create(:project)

    get :show, format: :json , params: { id: project.id }
    
      
    parsed_response = JSON.parse(response.body)
    id = parsed_response["id"]
    expect(id).to match(project.id)         
  end
end
context "when user is a developer" do
  it "returns a successful response without projects" do
    user = create(:user)
    sign_in(user)
    project = create(:project)
    
    get :show, format: :json , params: { id: project.id }
    
    expect(response).to have_http_status(:found)
   
  end
end 
  
end
  describe "GET #new" do
    it "returns a successful response" do
      get :new, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new project" do
      project_params = { name: "New Project", date: DateTime.now, creator: 1, status: 0 }
      expect {
        post :create, params: { project: project_params }
      }.to change(Project, :count).by(1)
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      project = Project.create(name: "Test Project", date: DateTime.now, creator: 1, status: 0)
      get :edit, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    it "updates the project" do
      project = Project.create(name: "Test Project", date: DateTime.now, creator: 1, status: 0)
      updated_params = { name: "Updated Project" }
      patch :update, params: { id: project.id, project: updated_params }
      project.reload
      expect(project.name).to eq("Updated Project")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the project" do
      project = Project.create(name: "Test Project", date: DateTime.now, creator: 1, status: 0)
      expect {
        delete :destroy, params: { id: project.id }
      }.to change(Project, :count).by(-1)
    end
  end
end
