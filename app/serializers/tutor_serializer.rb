class TutorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email
end