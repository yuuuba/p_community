class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @communities = Community.all
  end

  def show
    @user_count = @community.users.count
  end

  def new
    @user = current_user.id
    @community = Community.new
  end

  def create
    @user = current_user
    @community = Community.new(
      name: params[:community][:title],
      profile: params[:community][:profile]
    )

    @user.communities << @community

    if @community.save!
      redirect_to communities_path, notice: "「#{@community.name}を投稿しました」"
    else
      render :new, notice: "投稿に失敗しました"
    end
  end

  def edit
  end

  def update
    if @community.update(community_params)
      redirect_to communitys_path(@community.id)
    end
  end

  def destroy
    @community.destroy
    redirect_to communitys_url, notice: "投稿が削除されました"
  end

  private

    def set_community
      @community = Community.find(params[:id])
    end

    def community_params
      params.require(:community).permit(:title, :body, :user_id)
    end
end
