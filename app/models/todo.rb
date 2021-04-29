class Todo < ApplicationRecord
  validates :content, presence: true

  # broadcasts
  after_destroy_commit -> { broadcast_remove_to :todos }
  after_create_commit -> { broadcast_append_to :todos }
  after_update_commit -> { broadcast_replace_to :todos }


  def toggle
    self.completed = !self.completed
  end
end
