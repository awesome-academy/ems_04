module ExamsHelper
  def list_subject
    Subject.sort_by_name.active.map{|p| [p.subject_name, p.id]}
  end
end
