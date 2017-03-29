module ApplicationHelper
    def get_subdomain
        return request.subdomain.gsub!(".gst-alokrawat050","")
    end
end
