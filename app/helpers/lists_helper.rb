module ListsHelper
    def deposit(status)
        if status
          content_tag(:td, 'received')
        else
          content_tag(:td, 'not received')
        end
      end
end
