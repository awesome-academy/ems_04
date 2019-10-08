module ApplicationHelper
  # Return the full title on the per-page
  def full_title page_title
    base_title = I18n.t "title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_row name, ff, association, **args
    new_object = ff.object.send(association).klass.new
    id = new_object.object_id
    fields = ff.fields_for(association, new_object, child_index: id) do |ans|
      render(association.to_s.singularize, ff: ans)
    end
    link_to(name, "#", class: "add_fields " + args[:class],
      data: {id: id, fields: fields.delete("\n")})
  end
end
