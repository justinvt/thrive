require 'redcarpet'
module ApplicationHelper

  
  
  def nav_bar
    haml_tag :nav, navigation(Rails.configuration.app[:navigation])
  end
  
  def navigation(object)
    output = ""
    if object.is_a?(Hash)
        output << "<ul class='nav nav-justified'>"
        object.each do |k,v|

          output << "<li><a class='dropdown-togger' data-toggle='dropdown'>#{k.titleize}</a>#{ navigation(v)}</li>"
        end
      output << "</ul>"
    elsif object.is_a?(Array)
      output << "<ul class='dropdown-menu'>"
       object.each do |v|
        output << navigation(v) 
       end
       output << "</ul>"
    else
      url = url_for(:controller => "application", :action => :page, :page => object.split(" ")[0].underscore)
      output << "<li><a href=\"#{url}\">#{object}</a></li>"
    end
    raw output
  end
  
  
  
  def markdown(file_name)
    file = File.open(File.join(Rails.root, "pages",file_name ) + ".md", "r")
    data = file.read
    print data
    file.close
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new()
    md = Redcarpet::Markdown.new(renderer, extensions)

    md.render(data).html_safe + "ok"
  end
  
  
end
