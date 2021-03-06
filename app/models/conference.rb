class Conference < ActiveRecord::Base
  has_many :conference_to_extensions, :dependent => :destroy
  has_many :extensions, :through => :conference_to_extensions
  
  belongs_to :user
  
  accepts_nested_attributes_for :extensions
  
  #OPTIMIZE Validate presence of :user if :user_id is set.
  
  validates_numericality_of :pin, :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true
  #OPTIMIZE Fix the PIN validation. Make the database column a string instead of an integer.
  # This doesn't let you use PINs that start with "0" (except for 0 itself).
  #validates_format_of :pin, :with => /^[0-9]+$/, :allow_blank => true, :allow_nil => true
  
  validates_presence_of     :uuid
  validates_uniqueness_of   :uuid
  validate_username         :uuid
  # OPTIMIZE :uuid length = "-conference-" + 10
  validates_format_of       :uuid, :with => /^-conference-.*$/,
    :allow_nil => false, :allow_blank => false
  
  validates_uniqueness_of :name
end
