class Student < ApplicationRecord
  FIELDS = ["Mathematics", "Physics", "Computer Science"]

  validates :firstname, :lastname, :length => { :in => 3..20 }, :format => { :with => /\A[a-ząćęłńóśźżA-ZĄĆĘŁŃÓŚŹŻ]+\z/, :message => " contain(s) numbers" }
  validates :field, inclusion: FIELDS
end
