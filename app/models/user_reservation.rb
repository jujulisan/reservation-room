class UserReservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.busy?(start_time, end_time, room_id)
    where(room_id: room_id)
      .where.not('start > ? OR finish < ?', end_time, start_time)
      .exists?
  end
end
