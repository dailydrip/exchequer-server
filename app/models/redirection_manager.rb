class RedirectionManager
  class << self
    include Rails.application.routes.url_helpers

    def path_for(params_in_session)
      params_in_session = params_in_session.with_indifferent_access

      controller = params_in_session['controller']
      invoice_path(id: params_in_session['id']) if controller == 'invoices'
    end
  end
end
