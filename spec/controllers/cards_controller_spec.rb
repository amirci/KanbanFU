require 'spec_helper'

describe CardsController do

  let(:cards)   { fabricate(10).stub_for(:card) }
  let(:card)    { cards.first }
  let(:phases)  { fabricate(3).stub_for(:phase) }
  let(:project) { fabricate.stub_for(:project)  }
  
  let(:exceptions) { [:phase_id, :created_at, :updated_at] }

  before(:each) do    
    Project.stub(:find_by_id).with(project.id.to_s).and_return(project)
    Card.stub(:find_by_id).with(card.id.to_s).and_return(card)
  end

  it_behaves_like "any nested resource", Project, :project_id

  describe "#index" do
    context "with json format" do
      before { project.stub(:cards).and_return(cards) }
      before { get :index, :format => :json, :project_id => project.id }
      it { should respond_with :success }
      it { should respond_with_json({cards: cards}.to_json(:except => exceptions)) }
    end
  end

  describe "#show" do
    context "when card exists" do
      before { get :show, :format => :json, :project_id => project.id, :id => card.id }
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
    let(:card) { fabricate.stub_for(:card) }

    before do
      project.stub(:phases).and_return(phases)
      phases.first.stub(:cards).and_return(cards)
    end
    
    context "when the card is created successfully" do
      before do
        cards.stub(:create).and_return(card)
        post :create, :format => :json, :project_id => project.id, :card => card_attributes
      end

      it { should respond_with(:success) }
      it { should respond_with_json({card: card}.to_json(except: exceptions)) }
    end

    context "when the card is invalid" do
      before do
        cards.stub(:create).and_return(false)
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
      let(:updated_card) { stub_model(Card, :id => 1, :project_id => project.id, 
                                      :title => 'updated title', 
                                      :description => 'new description') }
      
      before do
        put :update, :format => :json, :project_id => project.id, :id => card.id, 
            :card => {:title => 'updated title', :description => 'new description'}
      end

      it { should respond_with(:success) }
      it { should respond_with_json({card: updated_card}.to_json(except: exceptions)) }
    end

    context "card is not updated" do
      before do
        card.should_receive(:update_attributes).and_return(false)
        put :update, :format => :json, :project_id => project.id, :id => card.id, 
            :card => {:title => ''}
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_json.as_null }
    end
  end

  describe '#delete' do
    before do
      project.stub_chain(:cards, :find_by_id).with(card.id.to_s).and_return(card)
    end

    context "card is deleted successfully" do
      before do
        card.should_receive(:destroy).and_return(true)
        delete :destroy, :format => :json, :project_id => project.id, :id => card.id
      end

      it { should respond_with(:success) }
      it { should respond_with_json.as_empty }
    end

    context "card is not deleted" do
      before do
        card.should_receive(:destroy).and_return(false)
        delete :destroy, :format => :json, :project_id => project.id, :id => card.id
      end

      it { should respond_with(:bad_request) }
      it { should respond_with_json.as_null }
    end
  end
end
