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
    let(:attrib)      {{name: 'Super project', description: 'Really super!'}}
    let(:new_project) {stub_model(Project, attrib)}
    let(:create_attrib) {{"name"=>"Super project", "description"=>"Really super!"}}

    # before { Project.stub(:new).and_return(new_project) }
    
    context "When create succeeds" do
      before do
        # given_saving_new_project(:succeeds)
        post :create, :format => :json, :project => attrib
      end

      it { should respond_with(:success) }
      it { should respond_with_json({project: new_project}.to_json(except: exceptions)) }
    end
    
    # context "When create fails" do
    #   before do
    #     # given_saving_new_project(:fails)
    #     post :create, :format => :json, :project => attrib
    #   end
    # 
    #   it { should respond_with(:error) }
    #   # it { should respond_with_json({project: new_project}.to_json(except: exceptions)) }
    # end
    
    def given_saving_new_project(succeeds) 
      new_project.should_receive(:save).and_return(succeeds == :succeeds)
    end
  end

  describe "#destroy" do
    let(:project) { stub_model(Project, Fabricate.attributes_for(:project)) }


    context "when project exists" do
      before { given_the_project_is(:found) }
      before do
        given_destroy(:succeeds)
        delete :destroy, :format => :json, :id => project.id
      end

      it { should respond_with(:success) }
      it { should respond_with_json.as_empty }
    end
    
    context "when project does not exist" do
      let(:not_found_json) {{message: "Not Found"}.to_json}
      
      before { given_the_project_is(:not_found) }
      before { delete :destroy, :format => :json, :id => project.id }
    
      it { should respond_with(:not_found) }
      it { should respond_with_json(not_found_json) }
    end

    context "when project exists but destroy fails" do
      before do
        given_the_project_is(:found)
        given_destroy(:fails)
        delete :destroy, :format => :json, :id => project.id
      end
    
      it { should respond_with(:error) }
      it { should respond_with_json.as_null }
    end
    
    def given_the_project_is(found) 
      Project.stub(:find_by_id).with(project.id.to_s).and_return(found == :found ? project : nil)
    end
    
    def given_destroy(success)
      project.should_receive(:destroy).and_return(success == :succeeds)
    end
    
  end
  
end

