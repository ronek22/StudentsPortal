class Student < ApplicationRecord
  FIELDS = ["Mathematics", "Medical Physics" ,"Physics", "Informatics", "Bioinformatics"]

  validates :firstname, :lastname, :length => { :in => 3..20 }, format: { with: /\A[A-ZĄĆĘŁŃÓŚŹŻ][a-ząćęłńóśźż]+\z/, message: " contain(s) numbers or/and first letter is small" }
  validates_uniqueness_of :pesel, :on => :create
  validates_with PeselValidator
  validates :field, inclusion: FIELDS

  def self.search(term, page)
    if term
      where("firstname LIKE ? OR lastname LIKE ? OR field LIKE ? OR pesel LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%").paginate(page: page, per_page:5).order("id ASC")
    else
      paginate(page: page, per_page:5).order('id ASC')
    end
  end
end
