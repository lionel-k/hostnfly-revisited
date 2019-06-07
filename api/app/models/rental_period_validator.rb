class RentalPeriodValidator < ActiveModel::Validator
  def validate(record)
    start_date = record.start_date
    end_date = record.end_date

    return if [start_date.blank?, end_date.blank?].any?

    if start_date > end_date
      record.errors.add(:rental_period, 'start_date must earlier than end_date')
    end
  end
end
