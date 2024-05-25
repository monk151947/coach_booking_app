# frozen_string_literal: true
class BookingController < ApplicationController
  def show 
  end

    def create
      slot = TimeSlot.find(booking_params[:time_slots_id])
      booking = Booking.new(time_slots_id: slot.id, coach_id: slot.availability.user.id,
                                    student_id: session[:student_id])
      if booking.save!
        slot.update(available: false)
        redirect_to action: :show, id: booking.id
      else
        render controller: :coach, action: :show, id: slot.availability.user.id
      end
    end

    private

    def booking_params
      params.permit(:time_slots_id)
    end
  end
