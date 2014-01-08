module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def edit_and_destroy_buttons(item)

    if user_signed_in?
      edit = link_to('Edit', url_for([:edit, item]), :class => "btn btn-warning")
      del = link_to('Destroy', item, method: :delete,
                                     data: { confirm: 'Are you sure?' },
                                     :class => "btn btn-danger")

      raw("#{edit} #{del}")
    end
  end

  def round(value)
    number_with_precision(value, precision: 1)
  end
end
