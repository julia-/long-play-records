module ProductsHelper
  def format_list(format_type)
    format_type.reject { |format| format == "Vinyl" || format == "Album" }.join(', ')
  end
end
