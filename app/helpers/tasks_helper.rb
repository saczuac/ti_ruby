module TasksHelper

  def last_updated_task(tasks)
    tasks.max_by {|t| t[:updated_at]}
  end

  def bind_task_params(task_params)
    priority = Priority.find_by(name: "#{task_params[:priority]}")
    state = State.find_by(name: "#{task_params[:state]}")
    tp = task_params
    tp[:list] = List.find(tp[:list])
    tp[:priority] = priority
    tp[:state] = state
    if tp[:type] == 'Simple'
      tp[:since], tp[:until], tp[:percent] = nil 
    elsif tp[:type] == 'Large'
      tp[:since], tp[:until] = nil
    else
      tp[:percent] = nil
    end
    tp
 end

end
