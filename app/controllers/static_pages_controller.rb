class StaticPagesController < ApplicationController
  before_action :redirect_if_user_not_admin, only: [:kk_enrollment]

  def home
  end

  def kk_enrollment
    @years = Result.uniq.pluck :year
  end
end
