class Link < ActiveRecord::Base
  belongs_to :user
  before_create :set_uid

  private

  def set_uid
    loop do
      self.uid = Utils.generate_uid(12)
      break unless Link.exists?(uid: uid)
    end
  end
end
