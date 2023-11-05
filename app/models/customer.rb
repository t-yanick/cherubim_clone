class Customer < ApplicationRecord
    has_many :goods
    def name_with_initial
        "#{first_name} #{last_name} #{email}"
      end
end
