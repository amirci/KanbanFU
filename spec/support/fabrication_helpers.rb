module FabricationHelpers
  
  def fabricate(count = 1)
    Multiple.new(count)
  end
  
  class Multiple
    include RSpec::Rails::Mocks
    
    def initialize(count)
      @count = count
    end
    
    def stub_for(symbol)
      multiple(:stub_model, symbol)
    end

    def mock_for(symbol) 
      multiple(:mock_model, symbol)
    end
    
    private
      def multiple(method, symbol)
        result = (1..3).map do 
          send(method, symbol.to_s.camelize.constantize, 
               Fabricate.attributes_for(symbol)) 
        end
        @count == 1 ? result.first : result
      end
  end
  
end

