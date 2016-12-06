module TasksHelper

  def set_expired_state(expireds_tasks)
  	#set expired state to expired tasks
    expireds_tasks.each do |e| 
      unless e.state_id == 4
        e.state_id = 4
        e.save
      end
    end
  end

  def last_updated_task(tasks)
    tasks.max_by {|t| t[:updated_at]}
  end

  def bind_task_params(task_params)
    priority = Priority.find_by(name: "#{task_params[:priority]}")
    state = State.find_by(name: "#{task_params[:state]}")
    tp = task_params
    tp[:priority] = priority
    tp[:state] = state
    if tp[:type] == 'Simple'
      tp[:since], tp[:until], tp[:percent] = nil 
    elsif tp[:type] == 'Large'
      tp[:since], tp[:until] = nil
    else
      tp[:percent] = nil
    end
    logger.debug "The task parameters are: #{tp.inspect}"
    tp
  end

end
