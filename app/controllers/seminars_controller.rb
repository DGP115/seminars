# frozen_string_literal: true

# Seminars controller
class SeminarsController < ApplicationController
  def index
    @seminars = Seminar.all.order(created_at: :asc)
    @upcoming_seminars = Seminar.upcoming_seminars.order(start_date: :ASC)
    @past_seminars = Seminar.past_seminars.order(end_date: :DESC)
  end

  def show
    set_seminar
  end

  def edit
    set_seminar
  end

  def update
    set_seminar
    if @seminar.update(whitelist_seminar_params)
      flash[:notice] = 'Seminar was updated successfully.'
      redirect_to seminar_path(@seminar)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    set_seminar
    if @seminar.destroy
      flash[:notice] = 'The seminar was deleted successfully.'
      redirect_to seminars_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def set_seminar
    @seminar = Seminar.find(params[:id])
  end

  def whitelist_seminar_params
    params.require(:seminar).permit(:name, :description, :start_date, :end_date,
                                    :start_time, :end_time, :total_seats, :registration_fee)
  end
end
