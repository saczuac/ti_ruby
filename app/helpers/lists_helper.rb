module ListsHelper

  def avaible_lists
    # returns an array of Lists 
    session[:lists].map { |k, v| List.find_by(slug: v[0]) }
  end

  def last_id
    session[:lists].length == 0 ? 0 : session[:lists].keys.last.to_i + 1
  end

  def add_list_to_session(slug)
     session[:lists][:"#{last_id.to_s}"] = [slug]
  end

end
