class SettsDrop   < Liquid::Drop
  # handles dynamic method names
  # from hash
  def liquid_method_missing(name)
    self.find_by_name(name)
  end

  def initialize(settings)
    @settings = settings
  end

  def find_by_name(name)
    @settings[name]
  end
end