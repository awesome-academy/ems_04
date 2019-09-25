let countdown = function() {
  const second = 1000,
        minute = second * 60,
        hour = minute * 60,
        day = hour * 24;

  let endDateVal = $('#remaining_time');
  let finishTime = new Date(endDateVal.val()).getTime();
  if (endDateVal.length > 0) {
    x = setInterval(function() {
      let now = new Date().getTime();
      let distance = finishTime - now;

      let hours = Math.floor((distance % (day)) / (hour));
      let minutes = Math.floor((distance % (hour)) / (minute));
      let seconds = Math.floor((distance % (minute)) / second);

      if (hours < '10') { hours = '0' + hours; }
      if (minutes < '10') { minutes = '0' + minutes; }
      if (seconds < '10') { seconds = '0' + seconds; }

      $('#hours').html(hours + "<span>hours</span>");
      $('#minutes').html(minutes + "<span>minutes</span>");
      $('#seconds').html(seconds + "<span>seconds</span>");

      if (distance < 0) {
        clearInterval(x);
        $('#hours').html('0' + "<span>hour</span>");
        $('#minutes').html('0' + "<span>minute</span>");
        $('#seconds').html('0' + "<span>second</span>");
      }

    }, second)
  }
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
