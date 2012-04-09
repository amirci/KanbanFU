class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :respond_with_not_found 
  
  def current_user
  end
  
  private
    def respond_with_not_found
      respond_with nil do |format|
        format.json { render json: nil, :status => :not_found }
      end
    end

    def render_json(item, options = {})
      options.reverse_merge! :except => [], :error_code => :not_found
      status = item ? :ok : options[:error_code]
      render :json => item, :status => status, :except => options[:except]
    end

    def render_not_found(message = 'Not Found')
      render :json => {:message => message}, :status => :not_found
    end

    def resource_found?(object, &block)
      if object
        return block.call(object)
      else
        render_not_found
      end
    end

end
