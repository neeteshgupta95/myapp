module ApplicationHelper
  def parse_liquid_template(template_path)
    template_content = File.read(Rails.root.join(template_path))
    Liquid::Template.parse(template_content)
  end
end
