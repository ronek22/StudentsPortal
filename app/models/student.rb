class Student < ApplicationRecord
  FIELDS = ["Mathematics", "Medical Physics" ,"Physics", "Informatics", "Bioinformatics"]

  validates :firstname, :lastname, :length => { :in => 3..20 }, format: { with: /\A[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+\z/, message: " contain(s) numbers or/and first letter is small" }
  validates_uniqueness_of :pesel, :on => :create
  validates_with PeselValidator
  validates :field, inclusion: FIELDS
end
