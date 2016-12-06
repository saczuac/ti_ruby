module ListsHelper
  def search(slug)
    session[:lists].each do |key, value|
      if slug == value[1]
        return key.to_s
      end
    end
    nil
  end

  def search_by_id(id)
    session[:lists].each do |key, value|
    	if key == id
    		return value[1]
    	end
    end
  end

end
