clientSideValidations.validators.local.confirmation = (element, options) ->
  confirmation = jQuery("#" + element.attr("id") + "_confirmation").val()
  if element.val() isnt confirmation and confirmation.length
    options.message
