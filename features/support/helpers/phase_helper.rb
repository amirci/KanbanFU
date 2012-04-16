module PhaseHelper

  def parse_phases_names(names)
    names.split(',').map { |name| Fabricate(:phase, name: name.strip) }
  end
  
end

World(PhaseHelper)