toggleTodoListFunctions = ->
	$('.todo-list-title').on 'click', (event) ->
		event.preventDefault()
		$functions = $('#todo-list-functions')
		if $functions.is(":hidden")
			$functions.slideDown('fast')
			$('.todo-list-title span').removeClass('fa-caret-down').addClass('fa-caret-up')
		else
			$functions.slideUp('fast')
			$('.todo-list-title span').removeClass('fa-caret-up').addClass('fa-caret-down')
		
$(document).ready toggleTodoListFunctions
$(document).on 'page:load', toggleTodoListFunctions