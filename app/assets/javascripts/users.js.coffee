$ ->

  profileSelect   = $("form#new_user").find("select#user_profile_type_id")
  studentSpecific = $("#students")
  icfSpecific     = $("#icf_members")

  resetProfileSpecificFields = ->
    studentSpecific.find("#user_training_program_id option:first").attr "selected", true
    icfSpecific.find("#user_icf_member_number").val("")

  toggleProfileSpecificOptions = ->
    optionName = $(@).find("option:selected").text()

    $(".profile-specific").hide()
    resetProfileSpecificFields()
    unless optionName is "Select membership type"
      $("form#new_user input").removeAttr "disabled"

    switch optionName
      when "ICF Member"
        icfSpecific.find("input#user_icf_member_number").attr "data-validate", true
        studentSpecific.find("input#user_graduation_date").removeAttr "data-validate"
        icfSpecific.show()
      when "Student"
        studentSpecific.find("input#user_graduation_date").attr "data-validate", true
        icfSpecific.find("input#user_icf_member_number").removeAttr "data-validate"
        studentSpecific.show()
      when "Select membership type"
        $("form#new_user input").attr "disabled", true

  $(profileSelect).on "change", toggleProfileSpecificOptions
  toggleProfileSpecificOptions.call profileSelect
  studentSpecific.find("#user_graduation_date").datepicker()
  studentSpecific.find("#user_graduation_date").datepicker "option", "dateFormat", "dd/mm/yy"
  $("#ui-datepicker-div").hide()
