# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PrintInvoiceExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/print_invoice"

  def self.require_gems(config)
    config.gem "prawn", :version => '0.8.4'
  end

  def activate

    Admin::OrdersController.class_eval do
      show.success.wants.pdf do
        if params[:gift]
          render :template => "admin/orders/gift", :layout => false
        else
          render :layout => false
        end
      end
    end

  end
end
