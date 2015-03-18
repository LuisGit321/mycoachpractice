form = $('.proposals-new').find 'form'

form.find('#program_attributes_start_from_date').datepicker()
form.find('#program_attributes_end_date').datepicker()

showTableMeta = $('.proposals-show').find('table').first()
$('.proposals-show').find('tr').css 'cursor', 'pointer'
