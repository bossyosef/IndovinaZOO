/* Delegato JQuery per la gestione del click sul pulsante 'Nuovo Animale'. */

$(document).delegate('#new_animal_link', 'ajax:success', function(e, data, status, xhr) {
	var $this = $(this),
		$container = $('#new_animal_links'),
		$responseText = $(xhr.responseText),
		$cancelButton = $responseText.find('#cancel_button');
		
	$container.replaceWith($responseText)
	$cancelButton.click(function(e) {
		$cancelButton.parent().replaceWith($container);
		e.preventDefault();
	});
});

