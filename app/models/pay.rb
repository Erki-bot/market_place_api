class Pay < ApplicationRecord
  validates :capital, presence: true
  validates_format_of :capital, with: /#/
end
