module JsonCustomMatchers

  RSpec::Matchers.define :respond_with_json do |expected|
    match do |actual|
      actual.should respond_with_content_type(:json)
      actual.response.body.should be_json_eql(expected || @expected)
    end
    
    chain :as_null do  
      @expected = "null"
    end

    chain :as_empty do 
      @expected = {}
    end
    
    failure_message_for_should do |actual|
      "expected that #{actual.response.body} would match the returned json #{expected}"
    end

    failure_message_for_should_not do |actual|
      "expected that #{actual.response.body} would not match the returned json #{expected}"
    end

    description do
      "should return json #{expected}"
    end
  end
  
end
