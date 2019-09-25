$(document).ready(function () {
  let formSubmit = $("#form_exam_submit");
  $("#submit_finish").attr("disabled", "disabled");
  $("input:checkbox, input:radio").change(function (){
    if ($('input:checkbox', formSubmit).is(':checked') ||
    $('input:radio', formSubmit).is(':checked')) {
      $("#submit_finish").removeAttr("disabled");
    }
  })
})
