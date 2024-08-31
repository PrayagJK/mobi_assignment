class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
  
  has_many :tutors
end
