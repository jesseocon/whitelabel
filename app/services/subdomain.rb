class Subdomain
  # Implement the .matches? method and pass in the request object
  def self.matches? request
    matching_site?(request)
  end

  def self.matching_site? request
    # handle the case of the user's domain being either www. or a root domain with one query
    if request.subdomain[0..2] == 'www'
      subdomain = request.subdomain[4..-1]
    else
      subdomain = request.subdomain
    end

    # first test if there exists a Site with a domain which matches the request,
    # if not, check the subdomain. If none are found, the the 'match' will not match anything
    # Site.where(:domain => req).any? ||
    Site.where(:slug => subdomain).any?
  end
end