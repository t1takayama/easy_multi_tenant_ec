module ApplicationHelper
  def admin_path?
    path = request.path
    pattern = /^\/admin/
    pattern.match?(path)
  end

  def owner_path?
    path = request.path
    pattern = /^\/owner/
    pattern.match?(path)
  end
end
