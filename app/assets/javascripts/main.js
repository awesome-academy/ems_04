$(document).on('turbolinks:load', function() {
  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

});

$(document).ready(function () {
  let formSubmit = $('#form_exam_submit');
  $('#submit_finish').attr('disabled', 'disabled');
  $('input:checkbox, input:radio').change(function (){
    if ($('input:checkbox', formSubmit).is(':checked') ||
    $('input:radio', formSubmit).is(':checked')) {
      $('#submit_finish').removeAttr('disabled');
    }
  })
})

$(document).on('turbolinks:load', function(){
  $('#subject-select').select2({
    width: '100%',
    theme: 'bootstrap4'
  });
  $('#user-select').select2({
    width: '100%',
    theme: 'bootstrap4'
  });
    $('#question_subject_id').select2({
    width: '100%',
    theme: 'bootstrap4'
  });
  $('#question_question_type').select2({
    width: '100%',
    theme: 'bootstrap4'
  });
    $('#qs-type-select').select2({
    width: '100%',
    theme: 'bootstrap4'
  });
  $('#datepicker').datepicker({defaultDate: new Date()});
});
