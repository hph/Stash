class Link < ActiveRecord::Base
  belongs_to :user
  has_many :trackings
  has_and_belongs_to_many :tags, unique: true
  before_create :set_uid
  before_create :fix_url
  validates :url, presence: true
  validates :name, presence: true

  def visible_to?(user_id)
    public? || self.user_id == user_id
  end

  def track!(user_id, ip)
    trackings.create(user_id: user_id, ip: ip)
  end

  def visit!
    self.visits += 1
    save
  end

  def tag!(names)
    names.split(',').map(&:strip).each do |name|
      tags << Tag.find_or_create_by(name: name)
    end
  end

  private

  def set_uid
    loop do
      self.uid = Utils.generate_uid(12)
      break unless Link.exists?(uid: uid)
    end
  end

  def fix_url
    self.url = "http://#{url}" if url[%r{^https?://}].nil?
  end
end
