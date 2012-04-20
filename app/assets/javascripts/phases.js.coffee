$(document).ready ->
  $("phase").sortable(
    connectWith: 'phase'
    placeholder: 'ui-state-highlight'
    stop: (event, ui) -> 
      phase = ui.item.parent()
      project_id = phase.parent().attr('id').match(/\d{1,}$/)
      card_id = ui.item.attr('id').match(/\d{1,}$/)
      phase_id = phase.attr('id').match(/\d{1,}$/)
      $.ajax(
        type: 'put'
        data: phase.sortable('serialize') + '&phase_id=' + phase_id
        dataType: 'script'
        complete: (request) -> $(ui.item).effect('highlight')
        url: "/projects/#{project_id}/cards/#{card_id}"
        )
	  )
  
  
