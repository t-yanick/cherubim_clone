module DepositsHelper
  def deposit(status)
    if status
      content_tag(:td, 'received')
    else
      content_tag(:td, 'not received')
    end
  end

  def customers_per_country(user)
    if user.role.name == 'admin'
      Customer.all
    else
      Customer.where(country: user.country)
    end
  end
end
