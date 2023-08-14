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
        
        get :index, format: :json                 
        
        expect(response).to redirect_to(root_path) 
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
  it "returns a successful response and renders the new project form" do
    user = create(:manager)    
    sign_in(user)    
    get :new    
    expect(response).to have_http_status(200)    
    expect(response).to render_template(:new)
  end
  it "returns a successful response and not renders the new project form" do
    user = create(:user)    
    sign_in(user)    
    get :new    
    expect(response).to have_http_status(:found)    
    expect(response).not_to render_template(:new)
  end
  end

  describe "POST #create" do
  context "when user is a manager" do
    it "creates a new project and redirects to the project's show page" do
      user = create(:manager)
      sign_in(user)
      project_attributes = attributes_for(:project)

      expect {
        post :create, params: { project: project_attributes }
      }.to change(Project, :count).by(1)

      created_project = Project.last
      expect(response).to redirect_to(project_path(created_project))
    end
    it "renders the 'new' template with invalid attributes" do
      user = create(:manager)
      sign_in(user)
      project_attributes = attributes_for(:project, name: "") 
      expect {
        post :create, params: { project: project_attributes }
      }.not_to change(Project, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end
  end
  context "when user is not a manager" do
    it "does not create a new project and redirects to a relevant page" do
      user = create(:user) 
      sign_in(user)
      project_attributes = attributes_for(:project)

      expect {
        post :create, params: { project: project_attributes }
      }.not_to change(Project, :count)

      expect(response).to redirect_to(root_path) 
    end
  end

  end
 
  describe "PATCH #update" do
  context "when user is a manager" do
    it "updates the project and redirects to the project's show page" do
      user = create(:manager)
      sign_in(user)
      project = create(:project)

      updated_name = "Updated Project Name"
      patch :update, params: { id: project.id, project: { name: updated_name } }

      project.reload
      expect(project.name).to eq(updated_name)
      expect(response).to redirect_to(project_path(project))
    end

    it "renders the 'edit' template with invalid attributes" do
      user = create(:manager)
      sign_in(user)
      project = create(:project)

      patch :update, params: { id: project.id, project: { name: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  context "when user is not a manager" do
    it "does not update the project and redirects to a relevant page" do
      user = create(:user)
      sign_in(user)
      project = create(:project)

      updated_name = "Updated Project Name"
      patch :update, params: { id: project.id, project: { name: updated_name } }

      project.reload
      expect(project.name).not_to eq(updated_name)
      expect(response).to redirect_to(root_path) 
    end
  end
  end

  describe "DELETE #destroy" do
    context "when user is a manager" do
      it "destroys the project and redirects to the projects index" do
        user = create(:manager)
        sign_in(user)
        project = create(:project)

        expect {
          delete :destroy, params: { id: project.id }
        }.to change(Project, :count).by(-1)

        expect(response).to redirect_to(projects_path)
      end
    end

    context "when user is not a manager" do
      it "does not destroy the project and redirects to a relevant page" do
        user = create(:user) 
        sign_in(user)
        project = create(:project)

        expect {
          delete :destroy, params: { id: project.id }
        }.not_to change(Project, :count)

        expect(response).to redirect_to(root_path) 
      end
    end
  end
end
