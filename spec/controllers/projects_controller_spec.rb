require 'spec_helper'

describe ProjectsController do

  let(:projects) { (1..10).map { |i| stub_model(Project, 
                                                  :id => i, 
                                                  :name => "project_#{i}", 
                                                  :description => "description_#{i}") } }

 let(:exceptions) { [:project_id, :created_at, :updated_at] }
                                                  
  describe '#index' do
    let(:json) { {projects: projects}.to_json(except: exceptions) }

    before do
      Project.stub(:all).and_return(projects)
      get :index, :format => :json
    end

    it { should respond_with(:success) }
    it { should respond_with_json json }
  end

  describe '#create' do
    let(:attrib)        { Fabricate.attributes_for(:project) }
    let!(:new_project)  { stub_model(Project, attrib) }
    let(:create_attrib) {{"name"=>"Super project", "description"=>"Really super!"}}

    context "When create succeeds" do
      before do
        Project.stub(:new).and_return(new_project)
        given_saving_new_project(:succeeds)
        post :create, :format => :json, :project => attrib
      end

      it { should respond_with(:created) }
      it { should respond_with_json({project: new_project}.to_json(except: exceptions)) }
    end
    
    context "When create fails" do
      let(:errors) { {saving: 'Saving failed!'} }
      
      before do
        Project.stub(:new).and_return(new_project)
        given_saving_new_project(:fails)
        post :create, :format => :json, :project => attrib
      end
    
      it { should respond_with(:unprocessable_entity) }
      it { should respond_with_json({errors: errors}.to_json) }
    end
    
    def given_saving_new_project(succeeds) 
      new_project.stub(:save).and_return(succeeds == :succeeds)
      new_project.stub(:errors).and_return(errors) if succeeds == :fails
      new_project.stub(:has_errors?).and_return(succeeds == :succeeds)
    end
  end

  describe "#destroy" do
    let(:project) { stub_model(Project, Fabricate.attributes_for(:project)) }
    let(:errors)  { {any: 'error'} }
 
    context "when project exists" do
      before do
        given_project_is(:found)
        given_project_destroy(:succeeds)
        delete :destroy, :format => :json, :id => project.id
      end

      it { should respond_with(:no_content) }
      it { should respond_with_json.as_null }
    end
    
    context "when project does not exist" do
      before { delete :destroy, :format => :json, :id => project.id }
    
      it { should respond_with(:not_found) }
      it { should respond_with_json.as_null }
    end

    context "when project exists but destroy fails" do
      before do
        given_project_is(:found)
        given_project_destroy(:fails)
        delete :destroy, :format => :json, :id => project.id
      end
    
      it { should respond_with(:unprocessable_entity) }
      it { should respond_with_json({:errors => errors}.to_json) }
    end
    
    def given_project_is(found) 
      Project.stub(:find).with(project.id.to_s).and_return(found == :found ? project : nil)
    end
    
    def given_project_destroy(success)
      project.stub(:errors).and_return(errors) unless success == :succeeds
      project.should_receive(:destroy).and_return(success == :succeeds)
    end
    
  end
  
end

