class Public::Api::V1::Portals::CategoriesController < Public::Api::V1::Portals::BaseController
  before_action :ensure_custom_domain_request, only: [:show, :index]
  before_action :portal
  before_action :set_category, only: [:show]
  layout 'portal'

  def index
    @categories = @portal.categories.order(position: :asc)
  end

  def show
    @og_image_url = helpers.set_og_image_url(@portal.name, @category.name)
  end

  private

  def set_category
    @category = @portal.categories.find_by(locale: params[:locale], slug: params[:category_slug])

    Rails.logger.info "Category: not found for slug: #{params[:category_slug]}"
    render_404 && return if @category.blank?
  end
end
