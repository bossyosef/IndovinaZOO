//delegato per l'evento change della prima select
$(document).delegate('#quiz_quiz_rows_attributes_0_animal_id', 'change', function(e) {
	e.preventDefault();
	var $select = $(this);	
	$.post("/quizzes/select_animal_id", {id: $select.val()}, null, "script");	
});

//delegato per intercettare il click sul tasto reset
$(document).delegate('#quizform_reset_button', 'click', function(e) {	
	$.post("/quizzes/select_animal_id", {id: ''}, null, "script");
});

//delegato per la gestione del link new quiz via AJAX
$(document).delegate('#new_quiz_link', 'ajax:success', function(e, data, status, xhr) {
	var $this = $(this),
		$container = $('#new_quiz_links'),
		$responseText = $(xhr.responseText),
		$cancelButton = $responseText.find('#cancel_button');
		
	$container.replaceWith($responseText)
	$cancelButton.click(function(e) {
		$cancelButton.parent().replaceWith($container);
		e.preventDefault();
	});
});
