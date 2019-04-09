module SiteLocator
  require 'active_support/concern'
  extend ActiveSupport::Concern
  included do
    def find_site
      if request.subdomain[0..2] == 'www'
        subdomain = request.subdomain[4..-1]
      else
        subdomain = request.subdomain
      end

      @site = current_user.sites.find_by(slug: subdomain)

      redirect_to root_url(subdomain: 'www') unless @site
    end

    def find_public_site
      if request.subdomain[0..2] == 'www'
        subdomain = request.subdomain[4..-1]
      else
        subdomain = request.subdomain
      end

      @site = Site.find_by(slug: subdomain)

      redirect_to root_url(subdomain: 'www') unless @site
    end
  end
end
