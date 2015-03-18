$ ->
  resourceName = $('body').attr('class').split('-')[0]
  $('ul.nav-pills li').removeClass 'active'
