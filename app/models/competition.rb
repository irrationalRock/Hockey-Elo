class Competition < ApplicationRecord
    belongs_to :league
    belongs_to :season
    has_many :teams
end
