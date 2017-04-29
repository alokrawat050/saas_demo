module ApplicationHelper
    def get_subdomain
        return request.subdomain.gsub!(".gst-alokrawat050","")
    end
    
    def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id= new_object.object_id
        fields=f.fields_for(association, new_object, child_index: id) do | builder |
            render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end
    
    def check_is_admin_rights?
        if current_user.is_admin
          true
        else 
          false
        end
    end
end
