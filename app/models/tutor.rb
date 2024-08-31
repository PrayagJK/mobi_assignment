class Tutor < ApplicationRecord
    belongs_to :course
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :course_id, presence: true
    validate :validate_course_id
    
    private
    
    def validate_course_id
        errors.add(:course_id, "is invalid") unless Course.exists?(self.course_id)
      end

end
