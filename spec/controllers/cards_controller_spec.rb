require 'spec_helper'

describe CardsController do

  let(:project) { stub_model(Project, id: 1, name: "Blazing Saddles", description: "Movie") }
  let(:cards)   { (1..10).map {|i| stub_model(Card, 
                                              :project_id => project.id, 
                                              :id => i, 
                                              :title => "card_#{i}", 
                                              :description => "description_#{i}") } }

  let(:card)       { cards.first }
  let(:exceptions) { [:project_id, :created_at, :updated_at] }

  before(:each) do
    project.stub(:cards).and_return(cards)
    Project.stub(:find_by_id).with(project.id.to_s).and_return(project)
  end

  it_behaves_like "any nested resource", Project, :project_id

  describe "#index" do
    let(:json) { {cards: cards}.to_json(:except => exceptions)}
    
    context "with json format" do
      before do
        get :index, :format => :json, :project_id => project.id
      end

      it { should respond_with :success }
      it { should respond_with_json(json) }
    end
  end

  describe "#show" do
    context "when card exists" do
      before do
        Card.stub(:find_by_id).with(card.id.to_s).and_return(card)
        get :show, :format => :json, :project_id => project.id, :id => card.id
      end

      it { should respond_with :success }
      it { should respond_with_json({card: card}.to_json(:except => exceptions)) }
    end

    context "when card doesn't exist"  do
      before do
        Card.stub(:find_by_id).with(card.id.to_s).and_return(nil)
        get :show, :format => :json, :project_id => project.id, :id => card.id
      end

      it { should respond_with :missing }
    end
  end

  describe '#create' do
    let(:card_attributes) { {:title => "card_1", :description => "description_1"} }
    let(:card) { stub_model(Card, card_attributes.merge({:project_id => project.id})) }

    before do
      Project.stub(:find_by_id).with(project.id.to_s).and_return(project)
    end

    context "when the card is created successfully" do
      before do
        project.stub_chain(:cards, :create).and_return(card)
        post :create, :format => :json, :project_id => project.id, :card => card_attributes
      end

      it { should respond_with(:success) }
      it { should respond_with_json({card: card}.to_json) }
    end

    context "when the card is invalid" do
      before do
        project.stub_chain(:cards, :create).and_return(false)
        post :create, :format => :json, :project_id => project.id, :card => {}
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_json.as_null }
    end
  end

  describe '#update' do
    before do
      project.stub_chain(:cards, :find_by_id).with(card.id.to_s).and_return(card)
    end

    context "card is updated successfully" do
      let(:updated_card) {stub_model(Card, :id => 1, :project_id => 1, :title => 'updated title', :description => 'new description')}
      let(:json) { {card: updated_card}.to_json }
      
      before do
        put :update, :format => :json, :project_id => project.id, :id => 1, 
            :card => {:title => 'updated title', :description => 'new description'}
      end

      it { should respond_with(:success) }
      it { should respond_with_json(json) }
    end

    context "card is not updated" do
      before do
        card.should_receive(:update_attributes).and_return(false)
        put :update, :format => :json, :project_id => project.id, :id => 1, 
            :card => {:title => ''}
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_json.as_null }
    end
  end

  describe '#delete' do
    before do
      Project.stub(:find_by_id).with(project.id.to_s).and_return(project)
      project.stub_chain(:cards, :find_by_id).with(card.id.to_s).and_return(card)
    end

    context "card is deleted successfully" do
      before do
        card.should_receive(:destroy).and_return(true)
        delete :destroy, :format => :json, :project_id => project.id, :id => 1
      end

      it { should respond_with(:success) }
      it { should respond_with_json.as_empty }
    end

    context "card is not deleted" do
      before do
        card.should_receive(:destroy).and_return(false)
        delete :destroy, :format => :json, :project_id => project.id, :id => 1
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_json.as_null }
    end
  end
end
