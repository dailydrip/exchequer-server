ActiveAdmin.register Coupon do
  index do
    column :offer
    column :name
    column :code
    column :percent_off do |p|
      "#{p.percent_off * 100} %" if p.percent_off
    end
    column :amount_off
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :offer,
        as: :searchable_select,
        collection: Offer.all,
        member_label: proc { |offer| offer.name.to_s }
      f.input :name
      f.input :code
      f.inputs 'Discount amount - pick only one'  do
        f.input :percent_off, label: 'Percent Off (in %)', input_html: { value: (f.object.percent_off.present? ? f.object.percent_off : 0) * 100 }
      end
      f.input :amount_off
    end
    f.actions
  end

  controller do
    def create
      percent = percent_in_decimal
      coupon = Coupon.create(permitted_params[:coupon].merge!(percent_off: percent))
      if coupon.errors
        redirect_to collection_path, notice: coupon.errors.full_messages
      else
        redirect_to collection_path
      end
    end

    def update
      percent = percent_in_decimal
      resource.update(permitted_params[:coupon].merge!(percent_off: percent))
      if coupon.errors
        redirect_to collection_path, notice: coupon.errors.full_messages
      else
        redirect_to collection_path
      end
    end

    def percent_in_decimal
      return nil if permitted_params[:coupon][:percent_off].to_f == 0
      percent = permitted_params[:coupon][:percent_off].to_f
      percent /= 100 if percent
      percent
    end
  end

  permit_params do
    %i[offer_id name percent_off amount_off code]
  end
end
