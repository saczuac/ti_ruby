module ListsHelper

  def last_update_of_list(slug)
    session[:lists].each do |key, value|
      if slug == value[1]
        return value[2]
      end 
    end    
  end

  def search(slug)
    # returns the id associated to the slug
    session[:lists].each do |key, value|
      if slug == value[1]
        return key.to_s
      end
    end
    nil
  end

  def search_by_id(id)
    # returns the slug associated to the id
    session[:lists].each do |key, value|
    	if key == id
    		return value[1]
    	end
    end
  end

  def find_name_by_slug(slug)
   # returns the name associated to the slug
    session[:lists].each do |key, value|
      if slug == value[1]
        return value[0]
      end 
    end
    nil
  end

  def is_in_lists?(slug)
    session[:lists].each do |key, value|
      if value[1] == slug
        return true
      end
    end
    return false
  end

  def avaible_lists
    # returns an array of hashes = {name: list_name, url: list_slug, updated_at: last_update_time}
    lists = []
    if session[:lists].length > 0
       session[:lists].each do |key, value|
        unless key.to_s == "0" #Lista 0 afuera...
          lists << {name: value[0], url: value[1], updated_at: value[2]}
        end
       end
    end
    lists
  end

  def exists_slug?(slug)
    session[:lists].each do |key, value|
      if value[1] == slug
        return true
      end 
    end
    false
  end

  def to_slug(name)
      #strip the string
      ret = name.strip.downcase
      #blow away apostrophes
      ret.gsub! /['`]/,""
      # @ --> at, and & --> and
      ret.gsub! /\s*@\s*/, " at "
      ret.gsub! /\s*&\s*/, " and "
      #replace all non alphanumeric, underscore or periods with underscore
      ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  
      #convert double underscores to single
      ret.gsub! /-+/,"-"
      #strip off leading/trailing underscore
      ret.gsub! /\A[-\.]+|[-\.]+\z/,""
      ret
  end

  def last_id
    session[:lists].length == 0 ? 0 : session[:lists].keys.last.to_i + 1
  end

  def save(name)
   begin
    unless exists_slug?(to_slug(name))
     session[:lists][:"#{last_id.to_s}"] = [name, to_slug(name), Time.now, Time.now]
    else 
      return false
    end
   rescue
     false
   end
    true
  end

  def list_update(new_name, old_name)
    session[:lists].each do |key, value|
      if value[0] == old_name
        value[0] = new_name
        value[2] = Time.now
        return 
      end
    end
  end

  def date_of_created(slug)
    session[:lists].each do |key,value|
      if value[1] == slug
        return value[3]
      end
    end
  end

end
