class LinksController < ApplicationController
  def index
    @links = Link.where(user_id: current_user.id).order('created_at DESC').all
  end

  def new
  end

  def create
    link = Link.create(link_params.merge(user_id: current_user.id))
    if link.persisted?
      redirect_to home_path
    else
      redirect_to new_link_path
    end
  end

  def show
    @link = Link.find_by_uid!(params[:uid])
  end

  def update
    link = Link.find_by_uid!(params[:uid])
    link.update_attributes(link_params)
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
