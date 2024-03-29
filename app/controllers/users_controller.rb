class UsersController < ApplicationController
  before_action :find_user, only: [:destroy]
  before_action :daily_records, only: [:index, :search]

  def index
    @users = User.all.map(&:to_liquid)
  end

  def search
    @users = User.search_by_name(params[:query]).map(&:to_liquid)

    render :index
  end

  def destroy
    @user.destroy

    redirect_to users_url, notice: 'User was successfully deleted.'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def daily_records
    @daily_records = DailyRecord.all.map(&:attributes)
  end
end
