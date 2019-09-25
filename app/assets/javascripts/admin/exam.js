$(document).on('turbolinks:load', function() {
  $(".mark").click(function(){
    let examId = $(this).attr("data-exam-id")
    $.ajax({
      type: 'PATCH',
      url: '/admin/exams/' + examId,
      success: function(data) {
        console.log(data)
        $("#score_" + examId).html(data.total_score)
        $("#passed_" + examId).html(data.passed)
        $("#correct_" + examId).html(data.total_correct + "/" + data.total_qs)
      }
    });
  });
});
