var strokePoints = [];
var xArray = [];
var yArray = [];
var isDown = false;
var recognizeTimer;
var languageList = [];
var canvas = document.getElementById('hwrCanvas');
var isMobile = /Android|webOS|iPhone|iPod|BlackBerry|Windows Phone/i.test(navigator.userAgent) ? true : false;
var helpPopupCookieName = 'SelvyPen_textDemoHelpVisible';
var strokeRecognize = true;
var serverUrl = 'http://220.86.110.146:8090/hwr';
var authHeader = 'Bearer dd7756c533f6415a9b8250e7fb06d59b7979ea8a0de54551a992c38fa7d666bf';

function Stroke(x, y) {
  this.x = x;
  this.y = y;
}

window.onload = function () {
  setHwrLanagues();
  setHwrCanvas();
  initialize();
  // openHelpPopup();
};

function setHwrLanagues() {
  $.ajax({
    url: serverUrl + '/languages',
    dataType: 'json',
    type: 'GET',
    beforeSend: function (xhr) {
      xhr.setRequestHeader('Authorization', authHeader);
    },
    success: function (result) {
      result.sort((a, b) => {
        if (a.english_name > b.english_name) {
          return 1;
        } else if (a.english_name < b.english_name) {
          return -1;
        } else {
          return 0;
        }
      });
      for (var index in result) {
        languageList[result[index]['english_name']] = result[index]['language'];
        $('#language').append('<option>' + result[index]['english_name'] + '</option>');
        if (result[index]['english_name'].indexOf('Korean') != -1) {
          $('#language').val(result[index]['english_name']).attr('selected', 'selected');
        }
      }
    },
  });
}

function touchDown() {
  isDown = true;
  if (!strokeRecognize) {
    $('.candidate-item').text(function () {
      return '';
    });
    if (recognizeTimer) {
      clearTimeout(recognizeTimer);
    }
  }
}

function touchMove() {
  if (xArray.length > 1 && yArray.length > 1) {
    $('canvas').drawLine({
      strokeStyle: '#00abf9',
      strokeWidth: 3,
      x1: xArray[xArray.length - 2],
      y1: yArray[yArray.length - 2],
      x2: xArray[xArray.length - 1],
      y2: yArray[yArray.length - 1],
    });
  }
}

function touchUp() {
  strokePoints.push(new Stroke(xArray, yArray));
  xArray = [];
  yArray = [];
  // console.log("[UP] x : " + event.clientX + " y : " + event.clientY);
  isDown = false;
  if (strokeRecognize) {
    recognize();
  } else {
    recognizeTimer = setTimeout(recognize, 800);
  }
}

function setMounsePos(event) {
  var mounseX = ((event.offsetX * canvas.width) / canvas.clientWidth) | 0;
  var mounseY = ((event.offsetY * canvas.height) / canvas.clientHeight) | 0;
  xArray.push(parseInt(mounseX));
  yArray.push(parseInt(mounseY));
  console.log('x : ' + xArray[xArray.length - 1] + ' y : ' + yArray[yArray.length - 1] + ' type : ' + event.type);
}

function setTouchPos(event) {
  var touches = event.originalEvent.touches;
  if (touches) {
    if (touches.length == 1) {
      // Only deal with one finger
      var touch = touches[0]; // Get the information for finger #1
      var touchX = (((touch.pageX - touch.target.offsetLeft) * canvas.width) / canvas.clientWidth) | 0;
      var touchY = (((touch.pageY - touch.target.offsetTop) * canvas.height) / canvas.clientHeight) | 0;
      xArray.push(touchX);
      yArray.push(touchY);
      console.log('x : ' + xArray[xArray.length - 1] + ' y : ' + yArray[yArray.length - 1] + ' type : ' + event.type);
    }
  }
}

function setHwrCanvas() {
  $('#hwrCanvas').on('mousedown', function (event) {
    setMounsePos(event);
    touchDown();
  });
  $('#hwrCanvas').on('mousemove', function (event) {
    if (isDown) {
      setMounsePos(event);
      touchMove();
    }
  });
  $('#hwrCanvas').on('mouseup', function (event) {
    setMounsePos(event);
    touchUp();
  });

  $('#hwrCanvas').on('touchstart', function (event) {
    setTouchPos(event);
    touchDown();
    event.preventDefault();
  });
  $('#hwrCanvas').on('touchmove', function (event) {
    if (isDown) {
      setTouchPos(event);
      touchMove();
    }
    event.preventDefault();
  });
  $('#hwrCanvas').on('touchend', function (event) {
    setTouchPos(event);
    touchUp();
    event.preventDefault();
  });

  // $('#hwrCanvas').on('mouseout', function (event) {
  //   isDown = false;
  //   clearCanvas();
  //   event.preventDefault();
  // });
}

function recognize() {
  console.log('recognize Click');
  var languageName = $('#language option:selected').val();
  console.log('language  : ' + languageName);
  var langCode = languageList[languageName];
  console.log('langCode  : ' + langCode);
  var dataJson = JSON.stringify({
    language: langCode,
    maxCandidateCount: 3,
    userSymbol: '',
    inks: strokePoints,
    // apiKey: '',
    includeNative: true,
    includeSymbol: true,
    includeNumber: true,
    includeEnglish: true,
    useGesture: false,
  });

  $.ajax({
    url: serverUrl + '/recognize',
    dataType: 'json',
    type: 'POST',
    data: dataJson,
    contentType: 'application/json',
    beforeSend: function (xhr) {
      xhr.setRequestHeader('Authorization', authHeader);
    },
    success: function (result) {
      console.log(result);
      if (result['candidates'].length == 0) {
        $('.candidate-item').text('No Result');
      } else {
        $('.candidate-item').text(function (index) {
          return result['candidates'][index];
        });
        // clearCanvas();
      }
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log('error');
    },
  });
}

function clearCanvas() {
  $('#hwrCanvas').clearCanvas();
  strokePoints.length = 0;
  drawGuideText();
}

function drawGuideText() {
  var navbarHeight = 69;
  var candidateHeight = 100;
  var margin = 30;
  var x = canvas.width / 2;
  var y = (canvas.height + navbarHeight + candidateHeight + margin) / 2;
  var ctx = canvas.getContext('2d');
  ctx.font = "30px 'Shadows Into Light'";
  ctx.fillStyle = '#e0e0e0';
  ctx.textAlign = 'center';
  ctx.fillText('Write here.', x, y);
}

function initialize() {
  window.addEventListener('resize', resizeCanvas, false);
  window.addEventListener('orientationchange', clearCanvas, false);
  resizeCanvas();
}

function redraw() {
  drawGuideText();
}

function resizeCanvas() {
  var html = document.documentElement;
  var margin = 8; // avoid to show scroll-bar
  canvas.width = html.clientWidth;
  canvas.height = html.clientHeight - margin;
  redraw();
}

function openHelpPopup() {
  if (getCookie(helpPopupCookieName) != 'no') {
    $('#helpPopup').modal('show');
  }
}

function setCookie(name, value, days) {
  var expires = '';
  if (days) {
    var date = new Date();
    date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
    expires = '; expires=' + date.toUTCString();
  }
  document.cookie = name + '=' + value + expires + '; path=/';
}

function getCookie(name) {
  if (document.cookie.length > 0) {
    start = document.cookie.indexOf(name + '=');
    if (start != -1) {
      start = start + name.length + 1;
      end = document.cookie.indexOf(';', start);
      if (end == -1) {
        end = document.cookie.length;
      }
      return unescape(document.cookie.substring(start, end));
    }
  }
  return '';
}

$('#clear').on('click', function (e) {
  clearCanvas();
  $('.candidate-item').text(function (index) {
    return '';
  });
});

$('#helpPopup').on('hidden.bs.modal', function (e) {
  var checked = $('#checkPopupAgain').is(':checked');
  setCookie(helpPopupCookieName, checked ? 'no' : '');
});

$('#helpPopup').on('show.bs.modal', function (e) {
  if (getCookie(helpPopupCookieName) == 'no') {
    document.getElementById('checkPopupAgain').checked = true;
  }
});
