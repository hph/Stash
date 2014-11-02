class LinksController < ApplicationController
  def index
    @page = request.path[1..-1]
    if @page == ''
      link_conds = {}
      tag_conds = ['links.user_id = ?', current_user.id]
    else
      link_conds = {category: @page}
      tag_conds = ['links.user_id = ? AND links.category = ?', current_user.id,
                   @page]
    end
    @links = current_user.links.where(link_conds).includes(:tags)
      .order('links.created_at DESC').all
    @tags = Tag.joins(:links).includes(:links).where(*tag_conds)
    @counts = @tags.map { |tag| [tag.id, tag.links.count] }.to_h
  end

  def new
    @category = params[:category]
    @query_param = @category ? {category: @category} : {}
  end

  def create
    link = Link.create(link_params.merge(user_id: current_user.id))
    if link.persisted?
      link.tag!(params[:link][:tags])
      if params[:category] == 'favourites'
        redirect_to favourites_path
      elsif params[:category] == 'unread'
        redirect_to unread_path
      else
        redirect_to home_path
      end
    else
      redirect_to new_link_path
    end
  end

  def show
    @link = Link.find_by_uid!(params[:uid])
    @tags = @link.tags.map { |tag| tag.name }.join(', ')
  end

  def update
    link = Link.find_by_uid!(params[:uid])
    link.update_attributes(link_params)
    if params[:link][:tags]
      link.tags.destroy_all
      link.tag!(params[:link][:tags])
    end
    render json: {link: link}
  end

  def destroy
    Link.find_by_uid!(params[:uid]).destroy
    render json: {}
  end

  def redirect
    link = Link.find_by_uid!(params[:uid])
    if link.visible_to?(current_user.id)
      link.track!(current_user.id, request.remote_ip)
      link.visit!(current_user.id)
      redirect_to link.url
    else
      not_found
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :name, :category, :public)
  end
end
