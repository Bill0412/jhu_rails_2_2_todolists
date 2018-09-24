class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: {in: ["male", "female"]}
  validate :first_last_name_not_both_null
  validate :male_not_having_first_name_sue

  scope :ordered_by_birth_year_asc, -> {order birth_year: :asc}

  def first_last_name_not_both_null
    if first_name.nil? and last_name.nil?
      errors.add(:first_name, "cannot be null when the last_name is null!")
    end
  end

  def male_not_having_first_name_sue
    if gender == "male" and first_name == "Sue"
      errors.add(:first_name, "cannot not be Sue when the gender is male!")
    end
  end

  def self.get_all_profiles(min, max)
    Profile.where("birth_year BETWEEN :min_year and :max_year", min_year: min, max_year: max).ordered_by_birth_year_asc
  end
end
