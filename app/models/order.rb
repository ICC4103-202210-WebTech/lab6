class Order < ApplicationRecord
  belongs_to :customer
  has_many :tickets

  before_create :init

  def init
    self.total ||= 0
  end
end
