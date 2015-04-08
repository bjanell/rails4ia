class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :author, class_name: 'User'
  belongs_to :state

  after_create :set_ticket_state

  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id: nil) }

  private

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end
end
