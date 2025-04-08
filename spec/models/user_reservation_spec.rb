require 'rails_helper'

RSpec.describe UserReservation, type: :model do
  describe '.busy?' do
    let(:room) { Room.create!(name: 'A1', capacity: 5 ) }
    let(:user) { User.create!(email: 'test@test.com', password: '12345678', password_confirmation:'12345678' ) }
    let!(:schedule) { UserReservation.create!( 
      room_id: room.id, 
      user_id: user.id, 
      start: "2025-03-30 14:00:00 +0000", finish: "2025-03-30 18:00:00 +0000")
    }

    context 'when the room is busy' do
      context 'scenario 1' do
        let(:start_time) { "2025-03-30 15:00:00 +0000" }
        let(:end_time) { "2025-03-30 17:00:00 +0000" }
        it 'returns true if the room is busy' do
          expect(UserReservation.busy?(start_time, end_time, room.id)).to be_truthy
        end
      end

      context 'scenario 2' do
        let(:start_time) { "2025-03-30 13:00:00 +0000" }
        let(:end_time) { "2025-03-30 19:00:00 +0000" }
  
        
        it 'returns false if the room is not busy' do
          expect(UserReservation.busy?(start_time, end_time, room.id)).to be_truthy
        end
      end

      
    end

    context 'when the room is not busy' do
      context 'scenario 1' do
        let(:start_time) { "2025-03-30 12:00:00 +0000" }
        let(:end_time) { "2025-03-30 13:00:00 +0000" }
        it 'returns true if the room is busy' do
          expect(UserReservation.busy?(start_time, end_time, room.id)).to be_falsey
        end
      end

      context 'scenario 2' do
        let(:start_time) { "2025-03-30 18:00:00 +0000" }
        let(:end_time) { "2025-03-30 19:00:00 +0000" }
  
        
        it 'returns false if the room is not busy' do
          expect(UserReservation.busy?(start_time, end_time, room.id)).to be_falsey
        end
      end
    end
  end
end
