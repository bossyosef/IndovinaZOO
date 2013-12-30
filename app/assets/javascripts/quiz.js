$.ajaxSetup({
	'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});

//delegato per l'evento change della prima select
$(document).delegate('#quiz_quiz_rows_attributes_0_animal_id', 'change', function(e) {
	
	var $select = $(this);	
	e.preventDefault();
	
	$.post("/quizzes/select_animal_id", {id: $select.val()}, null, "script");	
});

//delegato per intercettare il click sul tasto reset
$(document).delegate('#quizform_reset_button', 'click', function(e) {	
	$.post("/quizzes/select_animal_id", {id: ''}, null, "script");
});
