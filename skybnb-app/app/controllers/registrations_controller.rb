class RegistrationsController < Devise::RegistrationsController
	prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.
	
	private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        @recaptcha_error = "reCAPTCHA verification failed, please try again."
        respond_with_navigational(resource) { render :new }
      end 
    end
	
	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end
end