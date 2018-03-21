require 'date'

class PeselValidator < ActiveModel::Validator

  def validate(record)
    # generator peseli: https://bogus.000webhostapp.com/generatory/all.html
    sPesel = record.pesel
    if(Student.where(pesel: sPesel).any?)
      return record.errors.add(:pesel, "is already in database.")
    end

    unless(/\A\d{11}\z/ === sPesel)
      return record.errors.add(:pesel, "must contain 11 digits and only digits.")
    end

    unless(hasValidDate(sPesel))
      return record.errors.add(:pesel, "has incorrect date")
    end

    unless(hasValidCheckSum(sPesel))
      return record.errors.add(:pesel, "is incorrect, check sum is invalid.")
    end
  end

  private

  def hasValidCheckSum(pesel)
    factors = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]
    peselDigits = pesel.split(//).map{|x| x.to_i}

    products = factors.zip(peselDigits).map{|x| x.inject(:*)}
    (products.sum + peselDigits.last) % 10 == 0
  end

  def hasValidDate(pesel)
    peselDate = pesel[0...6]
    year, mm, day = peselDate.scan(/.{2}/).map{|x| x.to_i}
    century, month = centuryAndMonth(mm)
    Date.valid_date? century+year, month, day
  end

  def centuryAndMonth(mm)
    matchCentury = {0 => 1900, 1 => 2000, 2 => 2100, 3 => 2200, 4 => 1800}
    return matchCentury[(mm/20)], mm % 20
  end



end
