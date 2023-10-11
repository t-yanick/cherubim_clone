class Role < ApplicationRecord
  belongs_to :cherubim_user, optional: true
end
