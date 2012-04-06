require 'spec_helper'

describe ProjectsController do

  let(:projects) { (1..10).map { |i| stub_model(Project, 
                                                  :id => i, 
                                                  :name => "project_#{i}", 
                                                  :description => "description_#{i}") } }

  let(:exceptions) { [:project_id, :created_at, :updated_at] }
                                                  
  let(:json) { {projects: projects}.to_json(except: exceptions) }

  describe '#index' do
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
    
    before do
      # Project.stub(:new).and_return(new_project)
      # new_project.should_receive(:save).and_return(true)
      post :create, :format => :json, :project => attrib
    end

    it { should respond_with(:success) }
    it { should respond_with_json({project: new_project}.to_json(except: exceptions)) }
  end

end

