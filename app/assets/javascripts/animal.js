$(document).delegate('#new-animal-link', 'ajax:success', function(e, data, status, xhr) {
	var $this = $(this),
		$container = $('#new-animal-links'),
		$responseText = $(xhr.responseText),
		$cancelButton = $responseText.find('#cancel-button');
		
	$container.replaceWith($responseText)
	$cancelButton.click(function(e) {
		$cancelButton.parent().replaceWith($container);
		e.preventDefault();
	});
});

$(document).delegate('form[data-remote]', 'ajax:aborted:required', function(e, elements) {
	var $form = $(this),
		$errorDivId = 'error_messages',
		$errorDiv = $form.find('#' + errorDivId);
		
	if( !errorDiv.length) {
		$errorDiv = $('<div>', { id: errorDivId });
		$form.prepend($errorDiv);
	}
	
	$errorDiv.html("<h2>Devi inserire tutti i campi richiesti!</h2>");	
});

