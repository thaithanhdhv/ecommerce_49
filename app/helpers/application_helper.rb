module ApplicationHelper
  def full_title page_title
    base_title = I18n.t("sub_title")
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def create_index_row params_page, index, per_page
    params_page = Settings.cart_size if params_page.nil?
    (params_page.to_i - Settings.cart_size) * per_page.to_i + index.to_i + Settings.cart_size
  end
end
