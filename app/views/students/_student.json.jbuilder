json.extract! student, :id, :firstname, :lastname, :pesel, :field, :created_at, :updated_at
json.url student_url(student, format: :json)
