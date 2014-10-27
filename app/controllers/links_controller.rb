class LinksController < ApplicationController
  def index
    @links = Link.where(user_id: current_user.id).includes(:tags)
                 .order('links.created_at DESC').all
    @tags = Tag.joins(:links).includes(:links)
               .where('links.user_id = ?', current_user.id).all
    @counts = @tags.map { |tag| [tag.id, tag.links.count] }.to_h
  end

  def new
  end

  def create
    link = Link.create(link_params.merge(user_id: current_user.id))
    if link.persisted?
      link.tag!(params[:link][:tags])
      redirect_to home_path
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
    link.tags.destroy_all
    link.tag!(params[:link][:tags])
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
      link.visit!
      redirect_to link.url
    else
      not_found
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :name)
  end
end
