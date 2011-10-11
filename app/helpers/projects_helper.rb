module ProjectsHelper
  def phase_width(phase_count)
    width = 100.0 / phase_count
    {style: sprintf("width: %5.2f%", width)}
  end

  def phase_title(phase)
    phase.name + 
    (phase.wip ? " (#{phase.wip})" : '')
  end
  
  def card_size(card)
    card.size.blank? ? 'n/a' : card.size
  end
end
