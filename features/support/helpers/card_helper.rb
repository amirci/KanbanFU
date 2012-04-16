module CardHelper

  def current_card
    @current_card ||= Fabricate(:card)
  end
  
end

World(CardHelper)