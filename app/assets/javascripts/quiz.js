//delegato per l'evento change della prima select
$(document).delegate('#quiz_quiz_rows_attributes_0_animal_id', 'change', function(e) {
	e.preventDefault();
	var $select = $(this);	
	$.post("/quizzes/select_animal_id", {id: $select.val()}, null, "script");	
});

//delegato per intercettare il click sul tasto reset
$(document).delegate('#quizform_reset_button', 'click', function(e) {
	$('#quizform_error_messages').empty();		
	$.post("/quizzes/select_animal_id", {id: ''}, null, "script");	
});

//delegato per la gestione del link new quiz via AJAX
$(document).delegate('#new_quiz_link, .edit-quiz', 'ajax:success', function(e, data, status, xhr) {
	var $responseText = $(xhr.responseText),		
	    $cancelButton = $responseText.find('#cancel_button');
        
    if ($('#quiz_form_container').length)
		$container = $('#quiz_form_container');
		
	if ($('#new_quiz_links').length)
		$container = $('#new_quiz_links');
		
    $container.replaceWith($responseText);
    $cancelButton.click(function(e) {
        $('#quiz_form_container').replaceWith($container);
        $('#quizform_error_messages').empty();
        e.preventDefault();
    });
});
