class Tutor < ApplicationRecord
    belongs_to :course
    before_ :course_id_exists


    def course_id_exists
        return false if Course.find_by_id(course_id).nil?
    end
end
