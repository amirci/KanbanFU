$(document).ready ->
  $("phase").sortable(
    connectWith: 'phase'
    placeholder: 'ui-state-highlight'
    stop: (event, e) -> alert('Stopped!')
	  )
  
  
    #   phase = ui.item.parent().parent()
    #   card_id = ui.item.attr('id').match(/\d{1,}$/)
    #   phase_id = phase.attr('id').match(/\d{1,}$/)
    #   $.ajax(
    #     type: 'put'
    #     data: $(ui.item.parent()).sortable('serialize') + '&phase_id=' + phase_id
    #     dataType: 'script'
    #     complete: (request) ->
    #       $(ui.item).effect('highlight')
    #     url: "/projects/card/#{card_id}"
    #   )
    # )