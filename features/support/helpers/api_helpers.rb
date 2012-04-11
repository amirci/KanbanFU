module ApiHelpers

  def last_response
    @last_response
  end

  def last_json_response
    @last_response.body
  end
  
  def last_json
    page.source
  end
  
  def get_resource(path)
    @last_response = get path, :format => :json
  end
  
  def post_resource(post_path, resource, hashes)
    hashes.each do |attributes|
      post post_path, :format => :json, resource => attributes  
    end
  end

  def put_resource(put_path, resource, hashes)
    hashes.each do |attributes|
      put put_path, :format => :json, resource => attributes  
    end
  end

  def delete_resource(delete_path)
    @last_response = delete delete_path, :format => :json
  end

end

World(ApiHelpers)
